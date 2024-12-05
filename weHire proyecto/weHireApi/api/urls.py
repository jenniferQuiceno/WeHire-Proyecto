from django.urls import path
from .vistas.usuarios import UsuariosView
from .vistas.publicaciones import PublicacionesView
from .vistas.etapaInicial import EstapaInicialView
from .vistas.etapaMedia import EstapaMediaView
from .vistas.etapaFinal import EstapaFinalView
#from .views import listar_publicaciones
#PublicacionesView

urlpatterns =[
    path('usuarios/', UsuariosView.as_view(),name='usuarios_listar'),
    path('usuarios/<int:id>', UsuariosView.as_view(),name='usuarios_listar_id'),
    path('usuarios/<str:action>', UsuariosView.as_view(),name='usuarios_post'),
    path('publicaciones/', PublicacionesView.as_view(),name='publicaciones_listar'),    
    path('publicaciones/<int:id>', PublicacionesView.as_view(),name='publicaciones_listar_id'),
    path('publicaciones/<int:id>/<str:action>', PublicacionesView.as_view(),name='publicaciones_listar_id'),
    path('publicaciones/<str:action>',PublicacionesView.as_view(),name='publicaciones_post'),
    path('etapaInicial/', EstapaInicialView.as_view(),name='etapa_inicial_listar'),    
    path('etapaInicial/<int:id>', EstapaInicialView.as_view(),name='etapa_inicial_listar_id'),
    path('etapaInicial/<int:id>/<str:action>', EstapaInicialView.as_view(),name='etapa_inicial_listar_id_action'),
    path('etapaInicial/<str:action>',EstapaInicialView.as_view(),name='etaInicial_post'),
    path('etapaMedia/', EstapaMediaView.as_view(),name='etapa_media_listar'),    
    path('etapaMedia/<int:id>', EstapaMediaView.as_view(),name='etapa_media_listar_id'),
    path('etapaMedia/<str:action>',EstapaMediaView.as_view(),name='etapa_media_post'),
    path('etapaFinal/', EstapaFinalView.as_view(),name='etapa_final_listar'),    
    path('etapaFinal/<int:id>', EstapaFinalView.as_view(),name='etapa_final_listar_id'),
    path('etapaFinal/<str:action>',EstapaFinalView.as_view(),name='etapa_final_post'),
    path('publicacionesXreclutador/<int:id>', PublicacionesView.listar_publicaciones_reclutador, name='publicaciones_listar_por_reclutador'),
    path('misPostulaciones/<int:id>', PublicacionesView.listar_mis_postulaciones, name='listar_mis_postulaciones'),
    path('etapaInicialXPublicacion/<int:idPublicacion>', EstapaInicialView.etapaInicialPorPublicacion, name=''),
    path('etapaMediaXPublicacion/<int:idPublicacion>', EstapaMediaView.etapaMediaPorPublicacion, name=''),
    path('etapaFinalXPublicacion/<int:idPublicacion>', EstapaFinalView.etapaFinalPorPublicacion, name=''),
    path('misEtapas/<int:idPublicacion>/<int:idUsuario>', PublicacionesView.listar_etapas_por_publicacion_y_usuario, name=''),

]

