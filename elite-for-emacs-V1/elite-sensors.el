;;; elite-sensors.el -  Sensor functions for commander 

;; Elite for EMACS is based on Elite series by Ian Bell and David Braben.
;; Original Elite, (C) 1984 Ian Bell and David Braben.
;; Elite for EMACS uses code from original Elite and it is (C) 1984 Ian Bell and David Braben.
;; Additional code :
;; Author: Sami Salkosuo (sami@roguemail.net)


;; This file is not part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;sensor functions are used while in flying through space

(defvar elite-sensor-reading 0
  "greater than 0 if sensors have detected something. reseted after 2")

(defun elite-read-sensors (position)
  "Read sensor readings"
  (let (
	(msg "")
	(side (list "port" "starboard"))
	)
    (if (> elite-sensor-reading 0)
	(progn
	  (if elite-space-screen-use-windows
	      ()
	    (elite-space-sensor-insert-text (make-string 55 ? ))
	    )
	  (if (= elite-sensor-reading 1)
	      (progn
		(setq msg (concat msg "Unusual sensor reading disappeared."))
		(if elite-space-screen-use-windows
		    (elite-space-sensor-shell msg)
		  (elite-space-sensor-insert-text msg)
		  )
		(setq elite-sensor-reading (1+ elite-sensor-reading))		
		)
	    (progn
	      (setq elite-sensor-reading 0)
	      )
	    )
	  )
	  
      (progn
	(if (and (> (elite-rand1 t) 253))	
	    (progn	      
	      (setq msg (concat msg "Unusual sensor reading in " (nth (random (length side)) side) " bow."))
		(if elite-space-screen-use-windows
		    (elite-space-sensor-shell msg)
		  (elite-space-sensor-insert-text msg)
		  )
	      (setq elite-sensor-reading (1+ elite-sensor-reading))
	      )
	  )
	)
      )
    )
  )

(provide 'elite-sensors)