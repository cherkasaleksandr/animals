<?php
class ModelModuleAnimals extends Model {
	public function all_types() {
		$q = "SELECT * FROM `".DB_PREFIX."animals_types` ORDER BY `name`";
		$qq = $this->db->query($q);
		return $qq->rows;
	}
	
	public function add_types($post) {
		$q = "INSERT INTO `".DB_PREFIX."animals_types` SET `name` = '".$this->db->escape($post['name_types'])."', `gender_flag` = ".$post['gender_flag'];
		$this->db->query($q);
		return $this->db->countAffected();
	}
	
	public function dell_types($post) {
		
		$q = "SELECT COUNT(`id_breeds`) as count FROM `oc_animals_breeds` WHERE `id_types` = ".(int)$post['id_types'];
		$qq = $this->db->query($q)->row;
		
		if($qq['count'] == 0) {
			$q = "DELETE FROM `".DB_PREFIX."animals_types` WHERE `id_types` = ".(int)$post['id_types'];
			$this->db->query($q);
			return $this->db->countAffected();
		} else {
			
			return 100;
			
		}
		
	}
	
	public function upload_types($post) {
		$q = "SELECT * FROM `".DB_PREFIX."animals_types` WHERE `id_types` =".(int)$post['id_types'];
		$qq = $this->db->query($q);
		return $qq->row;
	}
	
	public function upload_types_yes($post) {
		$q = "UPDATE `".DB_PREFIX."animals_types` SET `name`= '".$this->db->escape($post['name_types'])."', `gender_flag` = ".$this->db->escape($post['gender_flag'])." WHERE `id_types` =".(int)$post['id_types'];
		$this->db->query($q);
		return $this->db->countAffected();
	}

//-------------------------------------------------------------------

	public function all_breeds($post) {
		
		$limit = $post['limit'];
		
		$q = "
			SELECT 
			`t`.`id_types`, 
			`t`.`name` as `name_t`,
			`b`.`id_breeds`,
			`b`.`name` as `name_b`

			FROM `".DB_PREFIX."animals_breeds` as `b`
			LEFT JOIN `".DB_PREFIX."animals_types` as `t` ON `t`.`id_types` = `b`.`id_types`
			ORDER BY `t`.`name`, `b`.`name`
			LIMIT ".$post['res_pagin'] * $limit .",".$limit
				;
	
		$qq = $this->db->query($q);
		return $qq->rows;
	}

	public function add_breeds($post){
		$q = "INSERT INTO `".DB_PREFIX."animals_breeds` SET `name` = '".$this->db->escape($post['name_breeds'])."', `id_types` =".(int)$post['id_types'];
		$this->db->query($q);
		return $this->db->countAffected();
		
	}
	
	public function upload_breeds($post){
		$q = "SELECT * FROM `".DB_PREFIX."animals_breeds` WHERE `id_breeds` =".(int)$post['id_breeds'];
		$qq = $this->db->query($q);
		return $qq->row;
	}
	
	public function upload_breeds_yes($post) {
		$q = "UPDATE `oc_animals_breeds` SET `name`= '".$this->db->escape($post['name_breeds'])."', `id_types` = ".(int)$post['id_types']." WHERE `id_breeds` =".(int)$post['id_breeds'];
		$this->db->query($q);
		return $this->db->countAffected();
	}
	
	public function dell_breeds($post){
		
		$q = "SELECT COUNT(`id_animals`) as count FROM `oc_animals_customer` WHERE `id_breeds` = ".(int)$post['id_breeds'];
		$qq = $this->db->query($q)->row;
			
		if($qq['count'] == 0) {
			$q = "DELETE FROM `".DB_PREFIX."animals_breeds` WHERE `id_breeds` =".(int)$post['id_breeds'];
			$this->db->query($q);
			return $this->db->countAffected();
		} else {
			
			return 100;
			
		}

	}
	
	public function select_count(){
		$q = "SELECT COUNT(`id_types`) as count FROM `".DB_PREFIX."animals_types`";
		$qq = $this->db->query($q);
		return $qq->row;
	}
//------------------------------------------------------------------------------------------------------

	public function count_breeds(){
		$q = "SELECT COUNT(`id_breeds`) as count FROM `".DB_PREFIX."animals_breeds`";
		$qq = $this->db->query($q);
		return $qq->row['count'];
	}



}