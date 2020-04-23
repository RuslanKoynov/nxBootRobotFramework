from pytz import timezone, utc
from django.conf import settings

TZ = timezone(settings.TIME_ZONE)

def convert_from_unix_to_iso8601(dt):
    return TZ.localize(dt.replace(microsecond=0)).astimezone(utc).replace(tzinfo=None).isoformat() + 'Z'