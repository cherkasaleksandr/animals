<?php
class ModelAccountAnimals extends Model {

	public function select_types() {
		$q = "SELECT * FROM `".DB_PREFIX."animals_types` ORDER BY `name`";
		$qq = $this->db->query($q);
		return $qq->rows;
	}
	
	public function select_breeds($post) {
		$q = "SELECT * FROM `".DB_PREFIX."animals_breeds` WHERE `id_types` =  ".(int)$post['id_types']." ORDER BY `name`";
		$qq = $this->db->query($q);
		return $qq->rows;
	}
	
	public function gender_flag($post) {
		$q = "SELECT `gender_flag` FROM `".DB_PREFIX."animals_types` WHERE `id_types` =  ".(int)$post['id_types'];
		$qq = $this->db->query($q);
		return $qq->row;
	}

	public function save_animals($post){
		
		$q = "SELECT 
				`t`.`id_types`,
				`t`.`gender_flag`,
				`b`.`id_breeds`
		FROM `".DB_PREFIX."animals_types` as `t`
		LEFT JOIN `".DB_PREFIX."animals_breeds` as `b` ON `t`.`id_types` = `b`.`id_types`
		
		WHERE `t`.`id_types` =  ".(int)$post['id_types']." 
		AND `b`.`id_breeds` =  ".(int)$post['id_breeds'];
		$qq = $this->db->query($q);
		
		
		$flag = count($qq->rows);
		$gender_flag = false;
		
		if ($flag == 1){
			$flag_gender = $qq->row;
		
			if($flag_gender['gender_flag'] == 0){
				if ((int)$post['gender'] == 0) $gender_flag = true;
			} else {
				if ((int)$post['gender'] == 1 && (int)$post['gender'] == 2) $gender_flag = true;	
			}
			
		}

		if ((int)$post['age_months'] > 0 && $gender_flag) {
		
			$q = "INSERT INTO `".DB_PREFIX."animals_customer` SET `id_types` = ".(int)$post['id_types'].", `id_breeds` = ".(int)$post['id_breeds'].", `id_customer` = ".(int)$this->customer->getId().", `gender` = ".(int)$post['gender'].", `age_months` = ".(int)$post['age_months']."";
			$this->db->query($q);
			return $this->db->countAffected();
		} else {
			return 100;
		}
		
		
	}
	
	public function all_animals(){
		$q = "SELECT 
				`c`.`id_animals`,
				`c`.`age_months`,
				`t`.`name` as `name_types`,
				`b`.`name` as `name_breeds`
		FROM `".DB_PREFIX."animals_customer` as `c`
		LEFT JOIN `".DB_PREFIX."animals_types` as `t` ON `c`.`id_types` = `t`.`id_types`
		LEFT JOIN `".DB_PREFIX."animals_breeds` as `b` ON `c`.`id_breeds` = `b`.`id_breeds`
		
		WHERE `id_customer` =  ".(int)$this->customer->getId()." 
		ORDER BY `name_types`, `name_breeds`";
	
		$qq = $this->db->query($q);
		return $qq->rows;
		
	}
	
	public function dell_animals($post){
		$q = "DELETE FROM `oc_animals_customer` WHERE `id_animals` = ".(int)$post['id_animals']." AND `id_customer` = ".(int)$this->customer->getId();
		$this->db->query($q);
		return $this->db->countAffected();	
	}

}