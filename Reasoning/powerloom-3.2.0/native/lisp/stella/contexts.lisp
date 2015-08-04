;;; -*- Mode: Lisp; Package: STELLA; Syntax: COMMON-LISP; Base: 10 -*-

;;; contexts.lisp

#|
+---------------------------- BEGIN LICENSE BLOCK ---------------------------+
|                                                                            |
| Version: MPL 1.1/GPL 2.0/LGPL 2.1                                          |
|                                                                            |
| The contents of this file are subject to the Mozilla Public License        |
| Version 1.1 (the "License"); you may not use this file except in           |
| compliance with the License. You may obtain a copy of the License at       |
| http://www.mozilla.org/MPL/                                                |
|                                                                            |
| Software distributed under the License is distributed on an "AS IS" basis, |
| WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License   |
| for the specific language governing rights and limitations under the       |
| License.                                                                   |
|                                                                            |
| The Original Code is the STELLA Programming Language.                      |
|                                                                            |
| The Initial Developer of the Original Code is                              |
| UNIVERSITY OF SOUTHERN CALIFORNIA, INFORMATION SCIENCES INSTITUTE          |
| 4676 Admiralty Way, Marina Del Rey, California 90292, U.S.A.               |
|                                                                            |
| Portions created by the Initial Developer are Copyright (C) 1996-2006      |
| the Initial Developer. All Rights Reserved.                                |
|                                                                            |
| Contributor(s):                                                            |
|                                                                            |
| Alternatively, the contents of this file may be used under the terms of    |
| either the GNU General Public License Version 2 or later (the "GPL"), or   |
| the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),   |
| in which case the provisions of the GPL or the LGPL are applicable instead |
| of those above. If you wish to allow use of your version of this file only |
| under the terms of either the GPL or the LGPL, and not to allow others to  |
| use your version of this file under the terms of the MPL, indicate your    |
| decision by deleting the provisions above and replace them with the notice |
| and other provisions required by the GPL or the LGPL. If you do not delete |
| the provisions above, a recipient may use your version of this file under  |
| the terms of any one of the MPL, the GPL or the LGPL.                      |
|                                                                            |
+---------------------------- END LICENSE BLOCK -----------------------------+
|#

(CL:IN-PACKAGE "STELLA")

;;; Auxiliary variables:

(CL:DEFVAR SGT-CONTEXTS-STELLA-CS-VALUE NULL)
(CL:DEFVAR SGT-CONTEXTS-STELLA-MODULE NULL)
(CL:DEFVAR SYM-CONTEXTS-STELLA-CC NULL)
(CL:DEFVAR KWD-CONTEXTS-COMMON-LISP NULL)
(CL:DEFVAR KWD-CONTEXTS-FUNCTION NULL)
(CL:DEFVAR SYM-CONTEXTS-STELLA-CCC NULL)
(CL:DEFVAR SYM-CONTEXTS-STELLA-WORLD-NAME NULL)
(CL:DEFVAR SGT-CONTEXTS-STELLA-WORLD NULL)
(CL:DEFVAR SYM-CONTEXTS-STELLA-STARTUP-CONTEXTS NULL)
(CL:DEFVAR SYM-CONTEXTS-STELLA-METHOD-STARTUP-CLASSNAME NULL)

;;; Forward declarations:

(CL:DECLAIM
 (CL:SPECIAL *STELLA-MODULE* *MODULE* STANDARD-OUTPUT EOL NULL-INTEGER
  *CLASS-HIERARCHY-BOOTED?* NULL-STRING-WRAPPER *PRINTREADABLY?* *CONTEXT*
  *ROOT-MODULE* NIL))

;;; (DEFGLOBAL *UNLINK-DISCARDED-CONTEXTS-ON-READ?* ...)

(CL:DEFVAR *UNLINK-DISCARDED-CONTEXTS-ON-READ?* CL:T
  "Eliminate pointers to discarded contexts while
accessing a CS-VALUE context table.")

;;; (DEFGLOBAL *UNLINK-DISCARDED-CONTEXTS-ON-WRITE?* ...)

(CL:DEFVAR *UNLINK-DISCARDED-CONTEXTS-ON-WRITE?* CL:T
  "Eliminate pointers to discarded contexts while
inserting into a CS-VALUE context table.")

;;; (DEFGLOBAL *CONTEXT-BACKTRACKING-MODE* ...)

(CL:DEFVAR *CONTEXT-BACKTRACKING-MODE* CL:NIL
  "If true, indicates that contexts are being allocated
and deallocated in depth-first fashion, and that deallocation of
CS-VALUE entries is taken care of during context destruction.")

;;; (DEFUN (CS-VALUE? BOOLEAN) ...)

(CL:DEFUN CS-VALUE? (SELF)
  (CL:RETURN-FROM CS-VALUE?
   (CL:AND (CL:NOT (CL:EQ SELF NULL))
    (CL:EQ (PRIMARY-TYPE SELF) SGT-CONTEXTS-STELLA-CS-VALUE))))

;;; (DEFUN (SUBCONTEXT? BOOLEAN) ...)

(CL:DEFUN SUBCONTEXT? (SUBCONTEXT SUPERCONTEXT)
  (CL:RETURN-FROM SUBCONTEXT?
   (CL:OR (CL:EQ SUBCONTEXT SUPERCONTEXT)
    (MEMB? (%ALL-SUPER-CONTEXTS SUBCONTEXT) SUPERCONTEXT))))

;;; (DEFUN (DISCARDED-CONTEXT? BOOLEAN) ...)

(CL:DEFUN DISCARDED-CONTEXT? (CONTEXT)
  (CL:RETURN-FROM DISCARDED-CONTEXT?
   (CL:LOGBITP 0 (CL:THE CL:FIXNUM (%CONTEXT-NUMBER CONTEXT)))))

;;; (DEFMETHOD (DELETED? BOOLEAN) ...)

(CL:DEFMETHOD DELETED? ((CONTEXT CONTEXT))
  (CL:RETURN-FROM DELETED?
   (CL:LOGBITP 0 (CL:THE CL:FIXNUM (%CONTEXT-NUMBER CONTEXT)))))

;;; (DEFUN (HELP-FIND-CONTEXT-BY-NUMBER CONTEXT) ...)

(CL:DEFUN HELP-FIND-CONTEXT-BY-NUMBER (NUMBER SIBLINGS)
  (CL:DECLARE (CL:TYPE CL:FIXNUM NUMBER))
  #+MCL
  (CL:CHECK-TYPE NUMBER CL:FIXNUM)
  (CL:LET* ((C NULL) (ITER-000 (%THE-CONS-LIST SIBLINGS)))
   (CL:LOOP WHILE (CL:NOT (CL:EQ ITER-000 NIL)) DO
    (CL:SETQ C (%%VALUE ITER-000))
    (CL:TAGBODY
     (CL:COND
      ((CL:= (%CONTEXT-NUMBER C) NUMBER)
       (CL:RETURN-FROM HELP-FIND-CONTEXT-BY-NUMBER C))
      ((CL:< (%CONTEXT-NUMBER C) NUMBER)
       (CL:RETURN-FROM HELP-FIND-CONTEXT-BY-NUMBER
        (HELP-FIND-CONTEXT-BY-NUMBER NUMBER (%CHILD-CONTEXTS C))))
      (CL:T (CL:GO :CONTINUE)))
     :CONTINUE)
    (CL:SETQ ITER-000 (%%REST ITER-000))))
  (CL:LET* ((STREAM-000 (NEW-OUTPUT-STRING-STREAM)))
   (%%PRINT-STREAM (%NATIVE-STREAM STREAM-000)
    "Couldn't find context with number `" NUMBER "'")
   (CL:ERROR (NEW-NO-SUCH-CONTEXT-EXCEPTION (THE-STRING-READER STREAM-000)))))

;;; (DEFUN (FIND-CONTEXT-BY-NUMBER CONTEXT) ...)

(CL:DEFUN FIND-CONTEXT-BY-NUMBER (CONTEXTNUMBER)
  (CL:DECLARE (CL:TYPE CL:FIXNUM CONTEXTNUMBER))
  #+MCL
  (CL:CHECK-TYPE CONTEXTNUMBER CL:FIXNUM)
  (CL:RETURN-FROM FIND-CONTEXT-BY-NUMBER
   (HELP-FIND-CONTEXT-BY-NUMBER CONTEXTNUMBER (%CHILD-CONTEXTS *ROOT-MODULE*))))

;;; (DEFMETHOD (GET-STELLA-CONTEXT-SLOWLY CONTEXT) ...)

(CL:DEFMETHOD GET-STELLA-CONTEXT-SLOWLY ((SELF CL:STRING))
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:LET* ((CONTEXT NULL))
   (CL:LET*
    ((CXT NULL) (ITER-000 (%THE-CONS-LIST (%CHILD-CONTEXTS *ROOT-MODULE*))))
    (CL:LOOP WHILE (CL:NOT (CL:EQ ITER-000 NIL)) DO
     (CL:SETQ CXT (%%VALUE ITER-000))
     (CL:WHEN (STRING-EQL? (CONTEXT-NAME CXT) SELF)
      (CL:RETURN-FROM GET-STELLA-CONTEXT-SLOWLY CXT))
     (CL:SETQ ITER-000 (%%REST ITER-000))))
   (CL:LET* ((CXT NULL) (ITER-001 (ALL-CONTEXTS)))
    (CL:LOOP WHILE (NEXT? ITER-001) DO (CL:SETQ CXT (%VALUE ITER-001))
     (CL:WHEN
      (CL:OR (STRING-EQL? (CONTEXT-NAME CXT) SELF)
       (CL:AND (ISA? CXT SGT-CONTEXTS-STELLA-MODULE)
        (CL:NOT (CL:EQ (%NICKNAMES CXT) NULL))
        (MEMBER? (%NICKNAMES CXT) (WRAP-STRING SELF))))
      (CL:WHEN (CL:NOT (CL:EQ CONTEXT NULL))
       (CL:LET* ((STREAM-000 (NEW-OUTPUT-STRING-STREAM)))
        (%%PRINT-STREAM (%NATIVE-STREAM STREAM-000)
         "More than one context has the name or nickname `" SELF "'")
        (CL:ERROR
         (NEW-NO-SUCH-CONTEXT-EXCEPTION (THE-STRING-READER STREAM-000)))))
      (CL:SETQ CONTEXT CXT))))
   (CL:IF (CL:NOT (CL:EQ CONTEXT NULL))
    (CL:RETURN-FROM GET-STELLA-CONTEXT-SLOWLY CONTEXT)
    (CL:LET* ((STREAM-001 (NEW-OUTPUT-STRING-STREAM)))
     (%%PRINT-STREAM (%NATIVE-STREAM STREAM-001)
      "No context with name or nickname `" SELF "'")
     (CL:ERROR
      (NEW-NO-SUCH-CONTEXT-EXCEPTION (THE-STRING-READER STREAM-001)))))))

;;; (DEFMETHOD (GET-STELLA-CONTEXT-SLOWLY CONTEXT) ...)

(CL:DEFMETHOD GET-STELLA-CONTEXT-SLOWLY ((SELF CL:INTEGER))
  (CL:DECLARE (CL:TYPE CL:FIXNUM SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:FIXNUM)
  (CL:RETURN-FROM GET-STELLA-CONTEXT-SLOWLY (FIND-CONTEXT-BY-NUMBER SELF)))

;;; (DEFMETHOD (GET-STELLA-CONTEXT-SLOWLY CONTEXT) ...)

(CL:DEFMETHOD GET-STELLA-CONTEXT-SLOWLY ((SELF SYMBOL))
  (CL:RETURN-FROM GET-STELLA-CONTEXT-SLOWLY
   (GET-STELLA-CONTEXT-SLOWLY (RELATIVE-NAME SELF))))

;;; (DEFUN (CHANGE-CONTEXT-SLOWLY CONTEXT) ...)

(CL:DEFUN CHANGE-CONTEXT-SLOWLY (SELF)
  (CL:IF (CL:NOT (CL:EQ SELF NULL))
   (CL:RETURN-FROM CHANGE-CONTEXT-SLOWLY (CHANGE-CONTEXT SELF))
   (CL:RETURN-FROM CHANGE-CONTEXT-SLOWLY *CONTEXT*)))

;;; (DEFUN (CC CONTEXT) ...)

(CL:DEFUN %CC (NAME)
  "Change the current context to the one named `name'.  Return the
value of the new current context.  If no `name' is supplied, return
the pre-existing value of the current context.  `cc' is a no-op if the
context reference cannot be successfully evaluated."
  (CL:LET* ((CONTEXT *CONTEXT*) (NAMESPEC (%%VALUE NAME)))
   (CL:WHEN (CL:NOT (CL:EQ NAMESPEC NULL))
    (CL:COND
     ((SUBTYPE-OF-INTEGER? (SAFE-PRIMARY-TYPE NAMESPEC))
      (CL:PROGN
       (CL:SETQ CONTEXT
        (GET-STELLA-CONTEXT-SLOWLY (%WRAPPER-VALUE NAMESPEC)))))
     (CL:T
      (CL:LET* ((CONTEXTNAME (COERCE-TO-MODULE-NAME NAMESPEC CL:T)))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING CONTEXTNAME))
       (CL:WHEN (CL:NOT (CL:EQ CONTEXTNAME STELLA::NULL-STRING))
        (CL:SETQ CONTEXT (GET-STELLA-CONTEXT CONTEXTNAME CL:T)))))))
   (CL:RETURN-FROM %CC (CHANGE-CONTEXT-SLOWLY CONTEXT))))

(CL:DEFUN CC-EVALUATOR-WRAPPER (ARGUMENTS)
  (CL:RETURN-FROM CC-EVALUATOR-WRAPPER (%CC ARGUMENTS)))

(CL:DEFMACRO CC (CL:&WHOLE EXPRESSION CL:&REST IGNORE)
  "Change the current context to the one named `name'.  Return the
value of the new current context.  If no `name' is supplied, return
the pre-existing value of the current context.  `cc' is a no-op if the
context reference cannot be successfully evaluated."
  (CL:DECLARE (CL:IGNORE IGNORE))
  (CL:LET ((*IGNORETRANSLATIONERRORS?* FALSE))
   (CL-INCREMENTALLY-TRANSLATE EXPRESSION)))

(CL:SETF (CL:MACRO-FUNCTION (CL:QUOTE |/STELLA/CC|)) (CL:MACRO-FUNCTION (CL:QUOTE CC)))

;;; (VERBATIM :COMMON-LISP ...)

(cl:defvar cl-user::*stella-case-sensitive-read-mode* :PRESERVE)

;;; (DEFUN (CCC CONTEXT) ...)

(CL:DEFUN %CCC (NAME)
  "Change the current context to the one named `name'.  Return the
value of the new current context.  If no `name' is supplied, return
the pre-existing value of the current context.  `cc' is a no-op if the
context reference cannot be successfully evaluated.
In CommonLisp, if the new context is case sensitive, then change
the readtable case to :INVERT, otherwise to :UPCASE."
  (CL:LET*
   ((CONTEXT *CONTEXT*) (NAMESPEC (%%VALUE NAME))
    (CASESENSITIVE? (%CASE-SENSITIVE? (%BASE-MODULE CONTEXT))))
   (CL:WHEN (CL:NOT (CL:EQ NAMESPEC NULL))
    (CL:COND
     ((SUBTYPE-OF-INTEGER? (SAFE-PRIMARY-TYPE NAMESPEC))
      (CL:PROGN
       (CL:SETQ CONTEXT
        (GET-STELLA-CONTEXT-SLOWLY (%WRAPPER-VALUE NAMESPEC)))))
     (CL:T
      (CL:LET* ((CONTEXTNAME (COERCE-TO-MODULE-NAME NAMESPEC CL:T)))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING CONTEXTNAME))
       (CL:WHEN (CL:NOT (CL:EQ CONTEXTNAME STELLA::NULL-STRING))
        (CL:SETQ CONTEXT (GET-STELLA-CONTEXT CONTEXTNAME CL:T)))))))
   (CL:if caseSensitive?
        (cl:setf (cl:readtable-case cl:*readtable*) 
                 cl-user::*stella-case-sensitive-read-mode*)
        (cl:setf (cl:readtable-case cl:*readtable*) :upcase))
   (CL:RETURN-FROM %CCC (CHANGE-CONTEXT-SLOWLY CONTEXT))))

(CL:DEFUN CCC-EVALUATOR-WRAPPER (ARGUMENTS)
  (CL:RETURN-FROM CCC-EVALUATOR-WRAPPER (%CCC ARGUMENTS)))

(CL:DEFMACRO CCC (CL:&WHOLE EXPRESSION CL:&REST IGNORE)
  "Change the current context to the one named `name'.  Return the
value of the new current context.  If no `name' is supplied, return
the pre-existing value of the current context.  `cc' is a no-op if the
context reference cannot be successfully evaluated.
In CommonLisp, if the new context is case sensitive, then change
the readtable case to :INVERT, otherwise to :UPCASE."
  (CL:DECLARE (CL:IGNORE IGNORE))
  (CL:LET ((*IGNORETRANSLATIONERRORS?* FALSE))
   (CL-INCREMENTALLY-TRANSLATE EXPRESSION)))

(CL:SETF (CL:MACRO-FUNCTION (CL:QUOTE |/STELLA/CCC|)) (CL:MACRO-FUNCTION (CL:QUOTE CCC)))

;;; (DEFUN PRINT-CONTEXT ...)

(CL:DEFUN PRINT-CONTEXT (SELF STREAM)
  (CL:LET*
   ((TYPESTRING STELLA::NULL-STRING) (NAME STELLA::NULL-STRING)
    (NUMBER (%CONTEXT-NUMBER SELF)))
   (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING TYPESTRING NAME)
    (CL:TYPE CL:FIXNUM NUMBER))
   (CL:WHEN (CL:NOT *CLASS-HIERARCHY-BOOTED?*)
    (%%PRINT-STREAM STREAM "|MDL|" (%MODULE-NAME SELF))
    (CL:RETURN-FROM PRINT-CONTEXT))
   (CL:LET* ((TEST-VALUE-000 (SAFE-PRIMARY-TYPE SELF)))
    (CL:COND
     ((SUBTYPE-OF? TEST-VALUE-000 SGT-CONTEXTS-STELLA-MODULE)
      (CL:PROGN (CL:SETQ NAME (%MODULE-FULL-NAME SELF))
       (CL:IF (CL:LOGBITP 0 (CL:THE CL:FIXNUM (%CONTEXT-NUMBER SELF)))
        (CL:SETQ TYPESTRING "|DeLeTeD MDL|") (CL:SETQ TYPESTRING "|MDL|"))))
     ((SUBTYPE-OF? TEST-VALUE-000 SGT-CONTEXTS-STELLA-WORLD)
      (CL:PROGN
       (CL:SETQ NAME
        (%WRAPPER-VALUE
         (DYNAMIC-SLOT-VALUE (%DYNAMIC-SLOTS SELF)
          SYM-CONTEXTS-STELLA-WORLD-NAME NULL-STRING-WRAPPER)))
       (CL:IF (CL:LOGBITP 0 (CL:THE CL:FIXNUM (%CONTEXT-NUMBER SELF)))
        (CL:SETQ TYPESTRING "|DeLeTeD WLD|") (CL:SETQ TYPESTRING "|WLD|"))))
     (CL:T
      (CL:LET* ((STREAM-000 (NEW-OUTPUT-STRING-STREAM)))
       (%%PRINT-STREAM (%NATIVE-STREAM STREAM-000) "`" TEST-VALUE-000
        "' is not a valid case option")
       (CL:ERROR (NEW-STELLA-EXCEPTION (THE-STRING-READER STREAM-000)))))))
   (CL:WHEN (CL:LOGBITP 0 (CL:THE CL:FIXNUM (%CONTEXT-NUMBER SELF)))
    (CL:SETQ NUMBER (CL:1+ NUMBER)))
   (CL:IF *PRINTREADABLY?*
    (CL:IF (CL:NOT (CL:EQ NAME STELLA::NULL-STRING))
     (%%PRINT-STREAM STREAM NAME)
     (%%PRINT-STREAM STREAM "#<" TYPESTRING NUMBER ">"))
    (CL:IF (CL:NOT (CL:EQ NAME STELLA::NULL-STRING))
     (%%PRINT-STREAM STREAM TYPESTRING NAME)
     (%%PRINT-STREAM STREAM TYPESTRING NUMBER))))
  :VOID)

;;; (DEFUN HELP-PRINT-CONTEXT-TREE ...)

(CL:DEFUN HELP-PRINT-CONTEXT-TREE (LIST LEVEL)
  (CL:DECLARE (CL:TYPE CL:FIXNUM LEVEL))
  #+MCL
  (CL:CHECK-TYPE LEVEL CL:FIXNUM)
  (CL:LET* ((C NULL) (ITER-000 (%THE-CONS-LIST LIST)))
   (CL:LOOP WHILE (CL:NOT (CL:EQ ITER-000 NIL)) DO
    (CL:SETQ C (%%VALUE ITER-000))
    (%%PRINT-STREAM (%NATIVE-STREAM STANDARD-OUTPUT) EOL)
    (CL:LET*
     ((I NULL-INTEGER) (ITER-001 1) (UPPER-BOUND-000 LEVEL)
      (UNBOUNDED?-000 (NULL? UPPER-BOUND-000)))
     (CL:DECLARE (CL:TYPE CL:FIXNUM I ITER-001 UPPER-BOUND-000))
     (CL:LOOP WHILE (CL:OR UNBOUNDED?-000 (CL:<= ITER-001 UPPER-BOUND-000)) DO
      (CL:SETQ I ITER-001) (CL:SETQ I I)
      (%%PRINT-STREAM (%NATIVE-STREAM STANDARD-OUTPUT) "   ")
      (CL:SETQ ITER-001 (CL:1+ ITER-001))))
    (%%PRINT-STREAM (%NATIVE-STREAM STANDARD-OUTPUT) (%CONTEXT-NUMBER C))
    (CL:WHEN (CL:NOT (CL:EQ (CONTEXT-NAME C) STELLA::NULL-STRING))
     (%%PRINT-STREAM (%NATIVE-STREAM STANDARD-OUTPUT) "   " (CONTEXT-NAME C)))
    (%%PRINT-STREAM (%NATIVE-STREAM STANDARD-OUTPUT) EOL)
    (HELP-PRINT-CONTEXT-TREE (%CHILD-CONTEXTS C) (CL:1+ LEVEL))
    (CL:SETQ ITER-000 (%%REST ITER-000))))
  :VOID)

;;; (DEFUN PRINT-CONTEXT-TREE ...)

(CL:DEFUN PRINT-CONTEXT-TREE (ROOT)
  (CL:WHEN (CL:EQ ROOT NULL) (CL:SETQ ROOT *ROOT-MODULE*))
  (CL:LET* ((TOPLIST (LIST ROOT))) (HELP-PRINT-CONTEXT-TREE TOPLIST 0)
   (FREE TOPLIST))
  :VOID)

;;; (DEFUN (ACCESS-IN-CONTEXT OBJECT) ...)

(CL:DEFUN ACCESS-IN-CONTEXT (VALUE HOMECONTEXT DONTINHERIT?)
  (CL:WHEN
   (CL:OR (CL:EQ VALUE NULL)
    (CL:NOT
     (CL:AND (CL:NOT (CL:EQ VALUE NULL))
      (CL:EQ (PRIMARY-TYPE VALUE) SGT-CONTEXTS-STELLA-CS-VALUE))))
   (CL:IF DONTINHERIT?
    (CL:WHEN (CL:EQ *CONTEXT* HOMECONTEXT)
     (CL:RETURN-FROM ACCESS-IN-CONTEXT VALUE))
    (CL:WHEN
     (CL:OR (CL:EQ HOMECONTEXT NULL)
      (CL:OR (CL:EQ *CONTEXT* HOMECONTEXT)
       (MEMB? (%ALL-SUPER-CONTEXTS *CONTEXT*) HOMECONTEXT))
      (CL:AND (ISA? HOMECONTEXT SGT-CONTEXTS-STELLA-MODULE)
       (VISIBLE-FROM? HOMECONTEXT *MODULE*)))
     (CL:RETURN-FROM ACCESS-IN-CONTEXT VALUE)))
   (CL:RETURN-FROM ACCESS-IN-CONTEXT NULL))
  (CL:LET* ((KVCONS (%THE-KV-LIST VALUE)) (CONTEXTNUMBER NULL-INTEGER))
   (CL:DECLARE (CL:TYPE CL:FIXNUM CONTEXTNUMBER))
   (CL:LET* ((TARGET *CONTEXT*))
    (CL:SETQ CONTEXTNUMBER (%CONTEXT-NUMBER TARGET))
    (CL:LOOP WHILE
     (CL:AND (CL:NOT (CL:EQ KVCONS NULL))
      (CL:< CONTEXTNUMBER (%CONTEXT-NUMBER (%KEY KVCONS))))
     DO
     (CL:IF
      (CL:AND
       (CL:LOGBITP 0 (CL:THE CL:FIXNUM (%CONTEXT-NUMBER (%KEY KVCONS))))
       (CL:NOT *CONTEXT-BACKTRACKING-MODE*)
       *UNLINK-DISCARDED-CONTEXTS-ON-READ?*)
      (CL:IF (CL:NOT (CL:EQ (%REST KVCONS) NULL))
       (CL:LET* ((NEXTKVCONS (%REST KVCONS)))
        (CL:SETF (%KEY KVCONS) (%KEY NEXTKVCONS))
        (CL:SETF (%VALUE KVCONS) (%VALUE NEXTKVCONS))
        (CL:SETF (%REST KVCONS) (%REST NEXTKVCONS)) (FREE NEXTKVCONS))
       (CL:PROGN (REMOVE-AT VALUE (%KEY KVCONS))
        (CL:RETURN-FROM ACCESS-IN-CONTEXT NULL)))
      (CL:SETQ KVCONS (%REST KVCONS))))
    (CL:WHEN (CL:EQ KVCONS NULL) (CL:RETURN-FROM ACCESS-IN-CONTEXT NULL))
    (CL:WHEN (CL:EQ TARGET (%KEY KVCONS))
     (CL:RETURN-FROM ACCESS-IN-CONTEXT (%VALUE KVCONS)))
    (CL:WHEN DONTINHERIT? (CL:RETURN-FROM ACCESS-IN-CONTEXT NULL)))
   (CL:LET* ((TARGET NULL) (ITER-000 (%ALL-SUPER-CONTEXTS *CONTEXT*)))
    (CL:LOOP WHILE (CL:NOT (CL:EQ ITER-000 NIL)) DO
     (CL:SETQ TARGET (%%VALUE ITER-000))
     (CL:SETQ CONTEXTNUMBER (%CONTEXT-NUMBER TARGET))
     (CL:LOOP WHILE
      (CL:AND (CL:NOT (CL:EQ KVCONS NULL))
       (CL:< CONTEXTNUMBER (%CONTEXT-NUMBER (%KEY KVCONS))))
      DO
      (CL:IF
       (CL:AND
        (CL:LOGBITP 0 (CL:THE CL:FIXNUM (%CONTEXT-NUMBER (%KEY KVCONS))))
        (CL:NOT *CONTEXT-BACKTRACKING-MODE*)
        *UNLINK-DISCARDED-CONTEXTS-ON-READ?*)
       (CL:IF (CL:NOT (CL:EQ (%REST KVCONS) NULL))
        (CL:LET* ((NEXTKVCONS (%REST KVCONS)))
         (CL:SETF (%KEY KVCONS) (%KEY NEXTKVCONS))
         (CL:SETF (%VALUE KVCONS) (%VALUE NEXTKVCONS))
         (CL:SETF (%REST KVCONS) (%REST NEXTKVCONS)) (FREE NEXTKVCONS))
        (CL:PROGN (REMOVE-AT VALUE (%KEY KVCONS))
         (CL:RETURN-FROM ACCESS-IN-CONTEXT NULL)))
       (CL:SETQ KVCONS (%REST KVCONS))))
     (CL:WHEN (CL:EQ KVCONS NULL) (CL:RETURN-FROM ACCESS-IN-CONTEXT NULL))
     (CL:WHEN (CL:EQ TARGET (%KEY KVCONS))
      (CL:RETURN-FROM ACCESS-IN-CONTEXT (%VALUE KVCONS)))
     (CL:WHEN DONTINHERIT? (CL:RETURN-FROM ACCESS-IN-CONTEXT NULL))
     (CL:SETQ ITER-000 (%%REST ITER-000))))
   (CL:RETURN-FROM ACCESS-IN-CONTEXT NULL)))

;;; (DEFUN HELP-INSERT-A-CS-VALUE ...)

(CL:DEFUN HELP-INSERT-A-CS-VALUE (KVCONS NEWVALUE TARGET OVERWRITE?)
  (CL:LET* ((CONTEXTNUMBER (%CONTEXT-NUMBER TARGET)))
   (CL:DECLARE (CL:TYPE CL:FIXNUM CONTEXTNUMBER))
   (CL:LOOP
    (CL:WHEN
     (CL:AND (CL:NOT *CONTEXT-BACKTRACKING-MODE*)
      *UNLINK-DISCARDED-CONTEXTS-ON-WRITE?*
      (CL:LOGBITP 0 (CL:THE CL:FIXNUM (%CONTEXT-NUMBER (%KEY KVCONS)))))
     (CL:IF (CL:NOT (CL:EQ (%REST KVCONS) NULL))
      (CL:LET* ((NEXTKVCONS (%REST KVCONS)))
       (CL:SETF (%KEY KVCONS) (%KEY NEXTKVCONS))
       (CL:SETF (%VALUE KVCONS) (%VALUE NEXTKVCONS))
       (CL:SETF (%REST KVCONS) (%REST NEXTKVCONS)) (FREE NEXTKVCONS))
      (CL:PROGN (CL:SETF (%KEY KVCONS) TARGET)
       (CL:SETF (%VALUE KVCONS) NEWVALUE)
       (CL:RETURN-FROM HELP-INSERT-A-CS-VALUE))))
    (CL:COND
     ((CL:EQ (%KEY KVCONS) TARGET)
      (CL:WHEN OVERWRITE? (CL:SETF (%VALUE KVCONS) NEWVALUE))
      (CL:RETURN-FROM HELP-INSERT-A-CS-VALUE))
     ((CL:< (%CONTEXT-NUMBER (%KEY KVCONS)) CONTEXTNUMBER)
      (CL:SETF (%REST KVCONS)
       (KV-CONS (%KEY KVCONS) (%VALUE KVCONS) (%REST KVCONS)))
      (CL:SETF (%KEY KVCONS) TARGET) (CL:SETF (%VALUE KVCONS) NEWVALUE)
      (CL:RETURN-FROM HELP-INSERT-A-CS-VALUE))
     ((CL:EQ (%REST KVCONS) NULL)
      (CL:SETF (%REST KVCONS) (KV-CONS TARGET NEWVALUE NULL))
      (CL:RETURN-FROM HELP-INSERT-A-CS-VALUE))
     (CL:T (CL:SETQ KVCONS (%REST KVCONS))))))
  :VOID)

;;; (DEFMETHOD INSERT-AT ...)

(CL:DEFMETHOD INSERT-AT ((SELF CS-VALUE) CONTEXT NEWVALUE)
  (CL:WHEN (CL:EQ (%THE-KV-LIST SELF) NULL)
   (CL:LET* ((KVCONS (NEW-KV-CONS))) (CL:SETF (%KEY KVCONS) CONTEXT)
    (CL:SETF (%VALUE KVCONS) NEWVALUE) (CL:SETF (%THE-KV-LIST SELF) KVCONS)
    (CL:RETURN-FROM INSERT-AT)))
  (HELP-INSERT-A-CS-VALUE (%THE-KV-LIST SELF) NEWVALUE CONTEXT CL:T)
  :VOID)

;;; (DEFUN (UPDATE-IN-CONTEXT OBJECT) ...)

(CL:DEFUN UPDATE-IN-CONTEXT (OLDVALUE NEWVALUE HOMECONTEXT COPYTOCHILDREN?)
  (CL:LET* ((CSVALUE NULL))
   (CL:IF
    (CL:AND (CL:NOT (CL:EQ OLDVALUE NULL))
     (CL:EQ (PRIMARY-TYPE OLDVALUE) SGT-CONTEXTS-STELLA-CS-VALUE))
    (CL:SETQ CSVALUE OLDVALUE)
    (CL:IF
     (CL:AND (CL:EQ HOMECONTEXT *CONTEXT*)
      (CL:OR (EMPTY? (%CHILD-CONTEXTS *CONTEXT*)) (CL:NOT COPYTOCHILDREN?)))
     (CL:RETURN-FROM UPDATE-IN-CONTEXT NEWVALUE)
     (CL:PROGN (CL:SETQ CSVALUE (NEW-CS-VALUE))
      (CL:WHEN (CL:NOT (CL:EQ OLDVALUE NULL))
       (INSERT-AT CSVALUE HOMECONTEXT OLDVALUE)))))
   (INSERT-AT CSVALUE *CONTEXT* NEWVALUE)
   (CL:WHEN COPYTOCHILDREN?
    (COPY-CURRENT-VALUE-TO-CHILDREN CSVALUE HOMECONTEXT NEWVALUE))
   (CL:RETURN-FROM UPDATE-IN-CONTEXT CSVALUE)))

;;; (DEFUN COPY-CURRENT-VALUE-TO-CHILDREN ...)

(CL:DEFUN COPY-CURRENT-VALUE-TO-CHILDREN (CSVALUE HOMECONTEXT PARENTVALUE)
  (CL:LET*
   ((CHILDCXT NULL) (ITER-000 (%THE-CONS-LIST (%CHILD-CONTEXTS *CONTEXT*))))
   (CL:LOOP WHILE (CL:NOT (CL:EQ ITER-000 NIL)) DO
    (CL:SETQ CHILDCXT (%%VALUE ITER-000))
    (CL:LET* ((*CONTEXT* CHILDCXT)) (CL:DECLARE (CL:SPECIAL *CONTEXT*))
     (CL:LET* ((CURRENTVALUE (ACCESS-IN-CONTEXT CSVALUE HOMECONTEXT CL:NIL)))
      (CL:WHEN (CL:NOT (EQL? CURRENTVALUE PARENTVALUE))
       (HELP-INSERT-A-CS-VALUE (%THE-KV-LIST CSVALUE) CURRENTVALUE CHILDCXT
        CL:NIL))))
    (CL:SETQ ITER-000 (%%REST ITER-000))))
  :VOID)

(CL:DEFUN STARTUP-CONTEXTS ()
  (CL:LET* ((*MODULE* *STELLA-MODULE*) (*CONTEXT* *MODULE*))
   (CL:DECLARE (CL:SPECIAL *MODULE* *CONTEXT*))
   (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 2)
    (CL:SETQ SGT-CONTEXTS-STELLA-CS-VALUE
     (INTERN-RIGID-SYMBOL-WRT-MODULE "CS-VALUE" NULL 1))
    (CL:SETQ SGT-CONTEXTS-STELLA-MODULE
     (INTERN-RIGID-SYMBOL-WRT-MODULE "MODULE" NULL 1))
    (CL:SETQ SYM-CONTEXTS-STELLA-CC
     (INTERN-RIGID-SYMBOL-WRT-MODULE "CC" NULL 0))
    (CL:SETQ KWD-CONTEXTS-COMMON-LISP
     (INTERN-RIGID-SYMBOL-WRT-MODULE "COMMON-LISP" NULL 2))
    (CL:SETQ KWD-CONTEXTS-FUNCTION
     (INTERN-RIGID-SYMBOL-WRT-MODULE "FUNCTION" NULL 2))
    (CL:SETQ SYM-CONTEXTS-STELLA-CCC
     (INTERN-RIGID-SYMBOL-WRT-MODULE "CCC" NULL 0))
    (CL:SETQ SYM-CONTEXTS-STELLA-WORLD-NAME
     (INTERN-RIGID-SYMBOL-WRT-MODULE "WORLD-NAME" NULL 0))
    (CL:SETQ SGT-CONTEXTS-STELLA-WORLD
     (INTERN-RIGID-SYMBOL-WRT-MODULE "WORLD" NULL 1))
    (CL:SETQ SYM-CONTEXTS-STELLA-STARTUP-CONTEXTS
     (INTERN-RIGID-SYMBOL-WRT-MODULE "STARTUP-CONTEXTS" NULL 0))
    (CL:SETQ SYM-CONTEXTS-STELLA-METHOD-STARTUP-CLASSNAME
     (INTERN-RIGID-SYMBOL-WRT-MODULE "METHOD-STARTUP-CLASSNAME" NULL 0)))
   (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 6) (FINALIZE-CLASSES))
   (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 7)
    (DEFINE-FUNCTION-OBJECT "CS-VALUE?"
     "(DEFUN (CS-VALUE? BOOLEAN) ((SELF OBJECT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (AND (DEFINED? SELF) (EQL? (PRIMARY-TYPE SELF) @CS-VALUE))))"
     (CL:FUNCTION CS-VALUE?) NULL)
    (DEFINE-FUNCTION-OBJECT "SUBCONTEXT?"
     "(DEFUN (SUBCONTEXT? BOOLEAN) ((SUBCONTEXT CONTEXT) (SUPERCONTEXT CONTEXT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (OR (EQL? SUBCONTEXT SUPERCONTEXT) (MEMB? (ALL-SUPER-CONTEXTS SUBCONTEXT) SUPERCONTEXT))))"
     (CL:FUNCTION SUBCONTEXT?) NULL)
    (DEFINE-FUNCTION-OBJECT "DISCARDED-CONTEXT?"
     "(DEFUN (DISCARDED-CONTEXT? BOOLEAN) ((CONTEXT CONTEXT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (ODD? (CONTEXT-NUMBER CONTEXT))))"
     (CL:FUNCTION DISCARDED-CONTEXT?) NULL)
    (DEFINE-METHOD-OBJECT
     "(DEFMETHOD (DELETED? BOOLEAN) ((CONTEXT CONTEXT)) :PUBLIC? TRUE)"
     (CL:FUNCTION DELETED?) NULL)
    (DEFINE-FUNCTION-OBJECT "HELP-FIND-CONTEXT-BY-NUMBER"
     "(DEFUN (HELP-FIND-CONTEXT-BY-NUMBER CONTEXT) ((NUMBER INTEGER) (SIBLINGS (LIST OF CONTEXT))))"
     (CL:FUNCTION HELP-FIND-CONTEXT-BY-NUMBER) NULL)
    (DEFINE-FUNCTION-OBJECT "FIND-CONTEXT-BY-NUMBER"
     "(DEFUN (FIND-CONTEXT-BY-NUMBER CONTEXT) ((CONTEXTNUMBER INTEGER)))"
     (CL:FUNCTION FIND-CONTEXT-BY-NUMBER) NULL)
    (DEFINE-METHOD-OBJECT
     "(DEFMETHOD (GET-STELLA-CONTEXT-SLOWLY CONTEXT) ((SELF STRING)))"
     (CL:FUNCTION GET-STELLA-CONTEXT-SLOWLY) NULL)
    (DEFINE-METHOD-OBJECT
     "(DEFMETHOD (GET-STELLA-CONTEXT-SLOWLY CONTEXT) ((SELF INTEGER)))"
     (CL:FUNCTION GET-STELLA-CONTEXT-SLOWLY) NULL)
    (DEFINE-METHOD-OBJECT
     "(DEFMETHOD (GET-STELLA-CONTEXT-SLOWLY CONTEXT) ((SELF SYMBOL)))"
     (CL:FUNCTION GET-STELLA-CONTEXT-SLOWLY) NULL)
    (DEFINE-FUNCTION-OBJECT "CHANGE-CONTEXT-SLOWLY"
     "(DEFUN (CHANGE-CONTEXT-SLOWLY CONTEXT) ((SELF CONTEXT)))"
     (CL:FUNCTION CHANGE-CONTEXT-SLOWLY) NULL)
    (DEFINE-FUNCTION-OBJECT "CC"
     "(DEFUN (CC CONTEXT) (|&REST| (NAME NAME)) :COMMAND? TRUE :PUBLIC? TRUE :EVALUATE-ARGUMENTS? FALSE :DOCUMENTATION \"Change the current context to the one named `name'.  Return the
value of the new current context.  If no `name' is supplied, return
the pre-existing value of the current context.  `cc' is a no-op if the
context reference cannot be successfully evaluated.\")" (CL:FUNCTION %CC)
     (CL:FUNCTION CC-EVALUATOR-WRAPPER))
    (DEFINE-FUNCTION-OBJECT "CCC"
     "(DEFUN (CCC CONTEXT) (|&REST| (NAME NAME)) :COMMAND? TRUE :PUBLIC? TRUE :EVALUATE-ARGUMENTS? FALSE :DOCUMENTATION \"Change the current context to the one named `name'.  Return the
value of the new current context.  If no `name' is supplied, return
the pre-existing value of the current context.  `cc' is a no-op if the
context reference cannot be successfully evaluated.
In CommonLisp, if the new context is case sensitive, then change
the readtable case to :INVERT, otherwise to :UPCASE.\")" (CL:FUNCTION %CCC)
     (CL:FUNCTION CCC-EVALUATOR-WRAPPER))
    (DEFINE-FUNCTION-OBJECT "PRINT-CONTEXT"
     "(DEFUN PRINT-CONTEXT ((SELF CONTEXT) (STREAM NATIVE-OUTPUT-STREAM)))"
     (CL:FUNCTION PRINT-CONTEXT) NULL)
    (DEFINE-FUNCTION-OBJECT "HELP-PRINT-CONTEXT-TREE"
     "(DEFUN HELP-PRINT-CONTEXT-TREE ((LIST (LIST OF CONTEXT)) (LEVEL INTEGER)))"
     (CL:FUNCTION HELP-PRINT-CONTEXT-TREE) NULL)
    (DEFINE-FUNCTION-OBJECT "PRINT-CONTEXT-TREE"
     "(DEFUN PRINT-CONTEXT-TREE ((ROOT CONTEXT)))"
     (CL:FUNCTION PRINT-CONTEXT-TREE) NULL)
    (DEFINE-FUNCTION-OBJECT "ACCESS-IN-CONTEXT"
     "(DEFUN (ACCESS-IN-CONTEXT OBJECT) ((VALUE OBJECT) (HOMECONTEXT CONTEXT) (DONTINHERIT? BOOLEAN)) :PUBLIC? TRUE)"
     (CL:FUNCTION ACCESS-IN-CONTEXT) NULL)
    (DEFINE-FUNCTION-OBJECT "HELP-INSERT-A-CS-VALUE"
     "(DEFUN HELP-INSERT-A-CS-VALUE ((KVCONS KV-CONS) (NEWVALUE OBJECT) (TARGET CONTEXT) (OVERWRITE? BOOLEAN)))"
     (CL:FUNCTION HELP-INSERT-A-CS-VALUE) NULL)
    (DEFINE-METHOD-OBJECT
     "(DEFMETHOD INSERT-AT ((SELF CS-VALUE) (CONTEXT CONTEXT) (NEWVALUE OBJECT)) :PUBLIC? TRUE)"
     (CL:FUNCTION INSERT-AT) NULL)
    (DEFINE-FUNCTION-OBJECT "UPDATE-IN-CONTEXT"
     "(DEFUN (UPDATE-IN-CONTEXT OBJECT) ((OLDVALUE OBJECT) (NEWVALUE OBJECT) (HOMECONTEXT CONTEXT) (COPYTOCHILDREN? BOOLEAN)) :PUBLIC? TRUE)"
     (CL:FUNCTION UPDATE-IN-CONTEXT) NULL)
    (DEFINE-FUNCTION-OBJECT "COPY-CURRENT-VALUE-TO-CHILDREN"
     "(DEFUN COPY-CURRENT-VALUE-TO-CHILDREN ((CSVALUE CS-VALUE) (HOMECONTEXT CONTEXT) (PARENTVALUE OBJECT)))"
     (CL:FUNCTION COPY-CURRENT-VALUE-TO-CHILDREN) NULL)
    (DEFINE-FUNCTION-OBJECT "STARTUP-CONTEXTS"
     "(DEFUN STARTUP-CONTEXTS () :PUBLIC? TRUE)"
     (CL:FUNCTION STARTUP-CONTEXTS) NULL)
    (CL:LET*
     ((FUNCTION (LOOKUP-FUNCTION SYM-CONTEXTS-STELLA-STARTUP-CONTEXTS)))
     (SET-DYNAMIC-SLOT-VALUE (%DYNAMIC-SLOTS FUNCTION)
      SYM-CONTEXTS-STELLA-METHOD-STARTUP-CLASSNAME
      (WRAP-STRING "_StartupContexts") NULL-STRING-WRAPPER)))
   (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 8) (FINALIZE-SLOTS)
    (CLEANUP-UNFINALIZED-CLASSES))
   (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 9)
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFGLOBAL *UNLINK-DISCARDED-CONTEXTS-ON-READ?* BOOLEAN TRUE :DOCUMENTATION \"Eliminate pointers to discarded contexts while
accessing a CS-VALUE context table.\")")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFGLOBAL *UNLINK-DISCARDED-CONTEXTS-ON-WRITE?* BOOLEAN TRUE :DOCUMENTATION \"Eliminate pointers to discarded contexts while
inserting into a CS-VALUE context table.\")")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFGLOBAL *CONTEXT-BACKTRACKING-MODE* BOOLEAN FALSE :DOCUMENTATION \"If true, indicates that contexts are being allocated
and deallocated in depth-first fashion, and that deallocation of
CS-VALUE entries is taken care of during context destruction.\")")
    (REGISTER-NATIVE-NAME SYM-CONTEXTS-STELLA-CC KWD-CONTEXTS-COMMON-LISP
     KWD-CONTEXTS-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-CONTEXTS-STELLA-CCC KWD-CONTEXTS-COMMON-LISP
     KWD-CONTEXTS-FUNCTION)))
  :VOID)