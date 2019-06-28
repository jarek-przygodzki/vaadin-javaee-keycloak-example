package web_app

import com.vaadin.cdi.CDIUI
import com.vaadin.server.VaadinRequest
import com.vaadin.ui.Label
import com.vaadin.ui.UI
import com.vaadin.ui.VerticalLayout
import com.vaadin.server.VaadinSession
import com.vaadin.server.VaadinService
import org.keycloak.KeycloakPrincipal


@CDIUI("")
class MainUI : UI() {

    protected override fun init(request: VaadinRequest) {
        initSession()
        val view = VerticalLayout()
        val keycloakPrincipal = VaadinSession.getCurrent().getAttribute("principal") as KeycloakPrincipal<*>
        val securityContext = keycloakPrincipal.getKeycloakSecurityContext()
        view.addComponent(Label("Hello ${securityContext.token.preferredUsername}!"))
        content = view
    }

    fun initSession() {
        val principal = VaadinService.getCurrentRequest()
            .userPrincipal
        VaadinSession.getCurrent()
            .setAttribute("principal", principal)
    }
}