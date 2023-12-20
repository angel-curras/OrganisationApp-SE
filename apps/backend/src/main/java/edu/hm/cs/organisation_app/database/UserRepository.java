package edu.hm.cs.organisation_app.database;

import edu.hm.cs.organisation_app.model.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface UsersRepository.
 *
 * @author Angel Curras Sanchez
 */
public interface UserRepository extends JpaRepository<AppUser, String> {

  /* Fields */

  /* Methods */

} // end of interface UsersRepository