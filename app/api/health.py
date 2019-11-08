from fastapi import APIRouter

api_health = APIRouter()


@api_health.get('/')
def liveliness_check() -> dict:
    return {'message': 'App is live!'}
