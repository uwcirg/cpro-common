from flask import Blueprint, render_template, make_response, jsonify, flash, redirect, url_for, request, current_app, Response, session
from cpro_common.models.cpro import Patient, MpowerUser
from ..auth import oauth, require_login, current_user


bp = Blueprint('api', __name__)

@bp.route('/patient/<int:id>')
@require_login
def patient(id):
    return Response(session['patient_data'], mimetype='text/xml')

@bp.route('/metadata')
def metadata():
    conf_xml = """
        <Conformance xmlns="http://hl7.org/fhir">

        <status value="active"/>
        <experimental value="true"/>
        <format value="xml"/>
        <rest>
        <mode value="server"/>
        <security>
        <cors value="true"/>
        <service>
        <text value="OAuth"/>
        <coding>
        <system value="http://hl7.org/fhir/ValueSet/restful-security-service"/>
        <code value="OAuth"/>
        <display value="OAuth"/>
        </coding>
        </service>
        <service>
        <text value="SMART-on-FHIR"/>
        <coding>
        <system value="http://hl7.org/fhir/ValueSet/restful-security-service"/>
        <code value="SMART-on-FHIR"/>
        <display value="SMART-on-FHIR"/>
        </coding>
        </service>
        <service>
        <text value="Basic"/>
        <coding>
        <system value="http://hl7.org/fhir/ValueSet/restful-security-service"/>
        <code value="Basic"/>
        <display value="Basic"/>
        </coding>
        </service>
        <extension url="http://fhir-registry.smarthealthit.org/StructureDefinition/oauth-uris">
        <extension url="authorize">
        <valueUri value="https://cpro.cirg.washington.edu/oauth2/authorize"/>
        </extension>
        <extension url="token">
        <valueUri value="https://cpro.cirg.washington.edu/oauth2/token"/>
        </extension>
        </extension>
        </security>
        <resource>
        <type value="Patient"/>
        <readHistory value="false"/>
        <updateCreate value="false"/>
        <conditionalCreate value="false"/>
        <conditionalUpdate value="false"/>
        <conditionalDelete value="not-supported"/>
        <interaction>
        <code value="read"/>
        </interaction>
        <interaction>
        <code value="search-type"/>
        </interaction>
        <searchParam>
        <name value="_id"/>
        <type value="token"/>
        <documentation value="Search for Patient resources using one or more server ids (equivalent to one or more Get /Patient/{ID} requests). If _id is included in your search, all other parameters are ignored."/>
        </searchParam>
        <searchParam>
        <name value="identifier"/>
        <type value="token"/>
        <documentation value="Search for Patient resources by a patient's identifier. You can use the identifier parameter as the only parameter in a search or in conjunction with other parameters. Queries must be in the format [OID]|[ID], where [OID] is the HL7 root of the identifier type. You can find this value in the Identifier.System field of a resource. If the query doesn't include an OID, the system searches over all patient identifier types."/>
        </searchParam>
        <searchParam>
        <name value="family"/>
        <type value="string"/>
        <documentation value="Search for Patient resources by family (last) name. You can use the family parameter along with the given (name) parameter to search by a patient's name or in conjunction with the birthdate parameter. Family name searching supports exact matching, "sounds like" matching, and patient aliases."/>
        </searchParam>
        <searchParam>
        <name value="given"/>
        <type value="string"/>
        <documentation value="Search for Patient resources by given (first) name. You must use the given parameter along with the family (name) parameter to search by a patient's name. Given name searching supports both exact and "sounds like" matches. Patient aliases and dominant name aliases (ex. Bob for Robert) are also supported."/>
        </searchParam>
        <searchParam>
        <name value="birthdate"/>
        <type value="date"/>
        <documentation value="Search for Patient resources using a date of birth in ISO format (YYYY-MM-DD). You must use this parameter with at least one other search parameter (excluding given and gender)."/>
        </searchParam>
        <searchParam>
        <name value="address"/>
        <type value="string"/>
        <documentation value="Search for Patient resources using an address string. You must use this parameter with one of the following parameters: identifier, telecom, family and given, or birthdate."/>
        </searchParam>
        <searchParam>
        <name value="gender"/>
        <type value="token"/>
        <documentation value="Search for Patient resources using the following gender codes: female, male, other, or unknown. You must use this parameter with one of the following sets of parameters: identifier, telecom, or family and given. Setting this parameter will filter results."/>
        </searchParam>
        <searchParam>
        <name value="telecom"/>
        <type value="string"/>
        <documentation value="Search for Patient resources using a patient's home, cell phone number, or email address. You can use this parameter as the only parameter in a search if it is set to a phone number. If an email address is entered, you must use this parameter with one of the following parameters: identifier, family and given, or birthdate. Queries can be formatted with or without dashes."/>
        </searchParam>
        </resource>    
        </rest>
        </Conformance>
        """
    return Response(conf_xml, mimetype='text/xml')
