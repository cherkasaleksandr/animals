<?php
class ControllerAccountAnimals extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/account', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->load->language('account/animals');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', 'SSL')
		);
		
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get($this->language->get('heading_title')),
			'href' => $this->url->link('account/animals', '', 'SSL')
		);

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_button_add'] = $this->language->get('text_button_add');
		$data['selected_types'] = $this->language->get('selected_types');
		$data['selected_breeds'] = $this->language->get('selected_breeds');
		$data['gender_man'] = $this->language->get('gender_man');
		$data['gender_woman'] = $this->language->get('gender_woman');
		$data['enter_types'] = $this->language->get('enter_types');
		$data['enter_breeds'] = $this->language->get('enter_breeds');
		$data['enter_gender'] = $this->language->get('enter_gender');
		$data['enter_age_months'] = $this->language->get('enter_age_months');
		$data['reply_fill'] = $this->language->get('reply_fill');
		$data['reply_save_ok'] = $this->language->get('reply_save_ok');
		$data['reply_error'] = $this->language->get('reply_error');
		$data['text_all_animals'] = $this->language->get('text_all_animals');
		$data['text_age_months'] = $this->language->get('text_age_months');
		$data['reply_dell_ok'] = $this->language->get('reply_dell_ok');
		$data['text_no_animals'] = $this->language->get('text_no_animals');
/*		$data[''] = $this->language->get('');
		$data[''] = $this->language->get('');
		$data[''] = $this->language->get('');
		$data[''] = $this->language->get('');
		$data[''] = $this->language->get('');
		$data[''] = $this->language->get('');
		$data[''] = $this->language->get('');
		$data[''] = $this->language->get('');
		$data[''] = $this->language->get('');
		$data[''] = $this->language->get('');
*/		


		if ($this->config->get('reward_status')) {
			$data['reward'] = $this->url->link('account/reward', '', 'SSL');
		} else {
			$data['reward'] = '';
		}

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/animals.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/animals.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/animals.tpl', $data));
		}
	}

	public function select_types() {
		$this->load->model('account/animals');
		$json = $this->model_account_animals->select_types();

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function select_breeds() {
		$this->load->model('account/animals');
		$json = $this->model_account_animals->select_breeds($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function gender_flag() {
		$this->load->model('account/animals');
		$json = $this->model_account_animals->gender_flag($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function save_animals(){
		$this->load->model('account/animals');
		$json = $this->model_account_animals->save_animals($this->request->post['data']);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}
	public function dell_animals(){
		$this->load->model('account/animals');
		$json = $this->model_account_animals->dell_animals($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}
	
	public function all_animals(){
		$this->load->model('account/animals');
		$json = $this->model_account_animals->all_animals();

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}
}
