<div class="checkout-tabs">
    <div class="row">
        <div class="col-lg-2">
            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist"
                aria-orientation="vertical">
            
                <a class="nav-link active" id="v-pills-gen-ques-tab" data-bs-toggle="pill"
                    href="#v-pills-gen-ques" role="tab" aria-controls="#v-pills-gen-ques#"
                    aria-selected="true">
                    <i class="bx bx-question-mark d-block check-nav-icon mt-4 mb-2"></i>
                    <p class="fw-bold mb-4">General</p>
                </a>

                <a class="nav-link" id="v-pills-privacy-tab" data-bs-toggle="pill"
                    href="#v-pills-privacy" role="tab" aria-controls="v-pills-privacy"
                    aria-selected="false">
                    <i class="bx bx-check-shield d-block check-nav-icon mt-4 mb-2"></i>
                    <p class="fw-bold mb-4">Surveyors</p>
                </a>
                <a class="nav-link" id="v-pills-support-tab" data-bs-toggle="pill"
                    href="#v-pills-support" role="tab" aria-controls="v-pills-support"
                    aria-selected="false">
                    <i class="bx bx-support d-block check-nav-icon mt-4 mb-2"></i>
                    <p class="fw-bold mb-4">Admin</p>
                </a>
            </div>
        </div>
        <div class="col-lg-10">
            <cfoutput>
                <div class="card">
                    <div class="card-body">
                        <div class="tab-content" id="v-pills-tabContent">
                            <div class="tab-pane fade show active" id="v-pills-gen-ques" role="tabpanel"
                                aria-labelledby="v-pills-gen-ques-tab">
                                <h4 class="card-title mb-5">General</h4>
                                <div class="faq-box d-flex align-items-start mb-4">
                                    <div class="faq-icon me-3">
                                        <i class="bx bx-help-circle font-size-20 text-success"></i>
                                    </div>
                                    <cfset faq_general = application.helper.getFaqs('General')>
                                    <cfloop query="faq_general">
                                        <div class="flex-1">
                                            <h5 class="font-size-15">#faqTitle#</h5>
                                            <p class="text-muted">#faqBody#</p>
                                        </div>
                                    </cfloop>                                
                                </div>
                            </div>
                            <div class="tab-pane fade" id="v-pills-privacy" role="tabpanel"
                                aria-labelledby="v-pills-privacy-tab">
                                <h4 class="card-title mb-5">Surveyors</h4>

                                <div class="faq-box d-flex align-items-start mb-4">
                                    <div class="faq-icon me-3">
                                        <i class="bx bx-help-circle font-size-20 text-success"></i>
                                    </div>
                                    <cfset faq_surveyors = application.helper.getFaqs('Surveyors')>
                                    <cfloop query="faq_surveyors">
                                        <div class="flex-1">
                                            <h5 class="font-size-15">#faqTitle#</h5>
                                            <p class="text-muted">#faqBody#</p>
                                        </div>
                                    </cfloop>                                
                                </div>
                            </div>
                            <div class="tab-pane fade" id="v-pills-support" role="tabpanel"
                                aria-labelledby="v-pills-support-tab">
                                <h4 class="card-title mb-5">Admin</h4>

                                <div class="faq-box d-flex align-items-start mb-4">
                                    <div class="faq-icon me-3">
                                        <i class="bx bx-help-circle font-size-20 text-success"></i>
                                    </div>
                                    <cfset faq_admin = application.helper.getFaqs('Admin')>
                                    <cfloop query="faq_admin">
                                        <div class="flex-1">
                                            <h5 class="font-size-15">#faqTitle#</h5>
                                            <p class="text-muted">#faqBody#</p>
                                        </div>
                                    </cfloop>                                
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </cfoutput>
        </div>
    </div>
</div>
