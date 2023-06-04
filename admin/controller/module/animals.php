<?php
class ControllerModuleAnimals extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('module/animals');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('module/animals');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('animals', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_tab1'] = $this->language->get('text_tab1');
		$data['text_tab2'] = $this->language->get('text_tab2');
		$data['button_add_types'] = $this->language->get('button_add_types');
		$data['button_add_breeds'] = $this->language->get('button_add_breeds');
		$data['text_gender_flag'] = $this->language->get('text_gender_flag');
		$data['text_name_types'] = $this->language->get('text_name_types');
		$data['text_add_types_ok'] = $this->language->get('text_add_types_ok');
		$data['text_add_types_off'] = $this->language->get('text_add_types_off');
		$data['text_dell_types_ok'] = $this->language->get('text_dell_types_ok');
		$data['text_upload_types_ok'] = $this->language->get('text_upload_types_ok');
		$data['text_name_breeds'] = $this->language->get('text_name_breeds');
		$data['text_upload_breeds_ok'] = $this->language->get('text_upload_breeds_ok');
		$data['text_add_breeds_ok'] = $this->language->get('text_add_breeds_ok');
		$data['text_dell_breeds_ok'] = $this->language->get('text_dell_breeds_ok');
		$data['text_dell_types_off'] = $this->language->get('text_dell_types_off');
		$data['text_dell_breeds_off'] = $this->language->get('text_dell_breeds_off');
		$data['text_limit'] = $this->language->get('text_limit');

	if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/animals', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['animals_status'])) {
			$data['animals_status'] = $this->request->post['animals_status'];
		} else {
			$data['animals_status'] = $this->config->get('animals_status');
		}


		$data['count_breeds'] = $this->model_module_animals->count_breeds();
		$data['token'] = $this->session->data['token'];

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/animals.tpl', $data));
	}
	
	
	public function all_types(){
		$this->load->model('module/animals');
		$json = $this->model_module_animals->all_types();

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}
	
	public function add_types(){
		$this->load->model('module/animals');
		$json = $this->model_module_animals->add_types($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}
	
	
	public function dell_types(){
		$this->load->model('module/animals');
		$json = $this->model_module_animals->dell_types($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}

	public function upload_types(){
		$this->load->model('module/animals');
		$json = $this->model_module_animals->upload_types($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function upload_types_yes(){
		$this->load->model('module/animals');
		$json = $this->model_module_animals->upload_types_yes($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
//--------------------------------------------------------------------------------------------------------
	public function select_types(){
		$this->load->model('module/animals');
		$json = $this->model_module_animals->all_types();

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}
	
	public function all_breeds(){
		$this->load->model('module/animals');
		$json = $this->model_module_animals->all_breeds($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}
	public function add_breeds(){
		$this->load->model('module/animals');
		$json = $this->model_module_animals->add_breeds($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
		
	}

	public function upload_breeds(){
		$this->load->model('module/animals');
		$json['breeds'] = $this->model_module_animals->upload_breeds($this->request->post);
		$json['select'] = $this->model_module_animals->all_types();
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
		
	}
	public function upload_breeds_yes(){
		$this->load->model('module/animals');
		$json = $this->model_module_animals->upload_breeds_yes($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
		
	}	
	public function dell_breeds(){
		$this->load->model('module/animals');
		$json = $this->model_module_animals->dell_breeds($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
		
	}	
	
	public function select_count(){
		$this->load->model('module/animals');
		$json = $this->model_module_animals->select_count();

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
		
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/animals')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}