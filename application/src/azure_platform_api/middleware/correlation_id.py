import re
from collections.abc import Awaitable, Callable
from uuid import uuid4

from fastapi import Request, Response

CORRELATION_ID_HEADER = "X-Correlation-ID"
CORRELATION_ID_PATTERN = re.compile(r"^[A-Za-z0-9._-]{1,128}$")

NextHandler = Callable[[Request], Awaitable[Response]]


async def add_correlation_id(
    request: Request,
    call_next: NextHandler,
) -> Response:
    incoming_correlation_id = request.headers.get(CORRELATION_ID_HEADER)

    if incoming_correlation_id and CORRELATION_ID_PATTERN.fullmatch(incoming_correlation_id):
        correlation_id = incoming_correlation_id
    else:
        correlation_id = str(uuid4())

    request.state.correlation_id = correlation_id

    response = await call_next(request)

    response.headers[CORRELATION_ID_HEADER] = correlation_id

    return response
