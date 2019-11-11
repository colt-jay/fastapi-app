from fastapi import APIRouter

router = APIRouter()


@router.get('/')
def liveliness_check() -> dict:
    return {'message': 'App is live!'}
