;;; -*- Mode: Lisp; Package: STELLA; Syntax: COMMON-LISP; Base: 10 -*-

;;; primal.lisp

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

(CL:DEFVAR SYM-PRIMAL-STELLA-FLOOR NULL)
(CL:DEFVAR KWD-PRIMAL-CPP NULL)
(CL:DEFVAR KWD-PRIMAL-FUNCTION NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-ROUND NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-FMOD NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-RANDOM NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-SQRT NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-COS NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-SIN NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-TAN NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-ACOS NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-ASIN NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-ATAN NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-ATAN2 NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-EXP NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-LOG NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-MIN NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-MAX NULL)
(CL:DEFVAR KWD-PRIMAL-UPCASE NULL)
(CL:DEFVAR KWD-PRIMAL-DOWNCASE NULL)
(CL:DEFVAR KWD-PRIMAL-CAPITALIZE NULL)
(CL:DEFVAR KWD-PRIMAL-PRESERVE NULL)
(CL:DEFVAR KWD-PRIMAL-LEFT NULL)
(CL:DEFVAR KWD-PRIMAL-RIGHT NULL)
(CL:DEFVAR KWD-PRIMAL-CENTER NULL)
(CL:DEFVAR KWD-PRIMAL-WHITE-SPACE NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-HASH-CODE NULL)
(CL:DEFVAR KWD-PRIMAL-JAVA NULL)
(CL:DEFVAR KWD-PRIMAL-TYPE-4 NULL)
(CL:DEFVAR KWD-PRIMAL-RANDOM NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-SLEEP NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-STARTUP-PRIMAL NULL)
(CL:DEFVAR SYM-PRIMAL-STELLA-METHOD-STARTUP-CLASSNAME NULL)

;;; Forward declarations:

(CL:DECLAIM
 (CL:SPECIAL *STELLA-MODULE* *MODULE* *TOKENIZER-INITIAL-BUFFER-SIZE*
  *USE-STELLA-HASH-TABLES?* *CHARACTER-TYPE-TABLE* *CHARACTER-UPCASE-TABLE*
  *CHARACTER-DOWNCASE-TABLE*))

;;; (DEFCONSTANT PI ...)

(CL:DEFVAR PI (cl:float CL:PI 0.0d0)
  "A float approximation of the mathematical constant pi.")
(CL:DECLAIM (CL:TYPE CL:DOUBLE-FLOAT PI))

;;; (DEFCONSTANT NULL-INTEGER ...)

(CL:DEFVAR NULL-INTEGER CL:MOST-NEGATIVE-FIXNUM)
(CL:DECLAIM (CL:TYPE CL:FIXNUM NULL-INTEGER))

;;; (DEFCONSTANT NULL-SHORT-INTEGER ...)

(CL:DEFVAR NULL-SHORT-INTEGER CL:MOST-NEGATIVE-FIXNUM)
(CL:DECLAIM (CL:TYPE CL:FIXNUM NULL-SHORT-INTEGER))

;;; (DEFCONSTANT NULL-LONG-INTEGER ...)

(CL:DEFVAR NULL-LONG-INTEGER CL:MOST-NEGATIVE-FIXNUM)

;;; (DEFCONSTANT NULL-UNSIGNED-SHORT-INTEGER ...)

(CL:DEFVAR NULL-UNSIGNED-SHORT-INTEGER CL:MOST-NEGATIVE-FIXNUM)

;;; (DEFCONSTANT NULL-UNSIGNED-LONG-INTEGER ...)

(CL:DEFVAR NULL-UNSIGNED-LONG-INTEGER CL:MOST-NEGATIVE-FIXNUM)

;;; (DEFCONSTANT NULL-FLOAT ...)

(CL:DEFVAR NULL-FLOAT CL:MOST-NEGATIVE-DOUBLE-FLOAT)
(CL:DECLAIM (CL:TYPE CL:DOUBLE-FLOAT NULL-FLOAT))

;;; (DEFCONSTANT NULL-SINGLE-FLOAT ...)

(CL:DEFVAR NULL-SINGLE-FLOAT CL:MOST-NEGATIVE-SINGLE-FLOAT)

;;; (DEFCONSTANT NULL-DOUBLE-FLOAT ...)

(CL:DEFVAR NULL-DOUBLE-FLOAT CL:MOST-NEGATIVE-DOUBLE-FLOAT)

;;; (DEFCONSTANT NULL-CHARACTER ...)

(CL:DEFVAR NULL-CHARACTER (CL:CODE-CHAR 0))

;;; (DEFCONSTANT NULL-BYTE ...)

(CL:DEFVAR NULL-BYTE 255)

;;; (DEFCONSTANT NULL-OCTET ...)

(CL:DEFVAR NULL-OCTET 255)

;;; (DEFUN (LISP-NULL-ARRAY-SYMBOL-STRING STRING) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:FIXNUM) CL:SIMPLE-STRING)
  LISP-NULL-ARRAY-SYMBOL-STRING))
(CL:DEFUN LISP-NULL-ARRAY-SYMBOL-STRING (RANK)
  (CL:DECLARE (CL:TYPE CL:FIXNUM RANK))
  #+MCL
  (CL:CHECK-TYPE RANK CL:FIXNUM)
  (CL:CASE RANK
   (1 (CL:RETURN-FROM LISP-NULL-ARRAY-SYMBOL-STRING "STELLA::NULL-1D-ARRAY"))
   (2 (CL:RETURN-FROM LISP-NULL-ARRAY-SYMBOL-STRING "STELLA::NULL-2D-ARRAY"))
   (3 (CL:RETURN-FROM LISP-NULL-ARRAY-SYMBOL-STRING "STELLA::NULL-3D-ARRAY"))
   (4 (CL:RETURN-FROM LISP-NULL-ARRAY-SYMBOL-STRING "STELLA::NULL-4D-ARRAY"))
   (5 (CL:RETURN-FROM LISP-NULL-ARRAY-SYMBOL-STRING "STELLA::NULL-5D-ARRAY"))
   (CL:OTHERWISE
    (CL:RETURN-FROM LISP-NULL-ARRAY-SYMBOL-STRING "STELLA::NULL"))))

;;; (DEFUN (EQL? BOOLEAN) ...)

(CL:DEFUN EQL? (X Y)
  "Return true if `x' and `y' are `eq?' or equivalent literals
such as strings that also might be wrapped in non-identical wrappers.  For
the case where `x' or `y' are plain literals such as strings or integers, the
STELLA translator substitutes the equality test appropriate for the particular
target language and does not actually call this function.  For cases where
`x' or `y' are known to be of type STANDARD-OBJECT, the STELLA translator
substitutes the faster `eq?' test inline."
  (CL:RETURN-FROM EQL?
   (CL:IF (CL:EQ X NULL) (CL:EQ Y NULL) (CL:OR (CL:EQ X Y) (OBJECT-EQL? X Y)))))

;;; (DEFUN (EQUAL? BOOLEAN) ...)

(CL:DEFUN EQUAL? (X Y)
  "Return true if `x' and `y' are `eql?' or considered equal
by a user-defined `object-equal?' method.  This implements a fully extensible
equality test similar to Java's `equals' method.  Note that writers of custom
`object-equal?' methods must also implement a corresponding `equal-hash-code'
method."
  (CL:RETURN-FROM EQUAL?
   (CL:IF (CL:EQ X NULL) (CL:EQ Y NULL)
    (CL:OR (CL:EQ X Y) (OBJECT-EQUAL? X Y)))))

;;; (DEFMETHOD (OBJECT-EQUAL? BOOLEAN) ...)

(CL:DEFMETHOD OBJECT-EQUAL? ((X OBJECT) Y)
  "Return true if `x' and `y' are `eq?'."
  (CL:RETURN-FROM OBJECT-EQUAL? (CL:EQ X Y)))

;;; (DEFMETHOD (OBJECT-EQUAL? BOOLEAN) ...)

(CL:DEFMETHOD OBJECT-EQUAL? ((X WRAPPER) Y)
  "Return true if `x' and `y' are literal wrappers whose
literals are considered `eql?'."
  (CL:RETURN-FROM OBJECT-EQUAL? (OBJECT-EQL? X Y)))

;;; (DEFUN (ZERO? BOOLEAN) ...)

(CL:DEFUN ZERO? (X)
  "Return true if `x' is 0."
  (CL:DECLARE (CL:TYPE CL:FIXNUM X))
  #+MCL
  (CL:CHECK-TYPE X CL:FIXNUM)
  (CL:RETURN-FROM ZERO? (CL:= X 0)))

;;; (DEFUN (PLUS? BOOLEAN) ...)

(CL:DEFUN PLUS? (X)
  "Return true if `x' is greater than 0."
  (CL:DECLARE (CL:TYPE CL:FIXNUM X))
  #+MCL
  (CL:CHECK-TYPE X CL:FIXNUM)
  (CL:RETURN-FROM PLUS? (CL:> X 0)))

;;; (DEFUN (EVEN? BOOLEAN) ...)

(CL:DEFUN EVEN? (X)
  "Return true if `x' is an even number."
  (CL:DECLARE (CL:TYPE CL:FIXNUM X))
  #+MCL
  (CL:CHECK-TYPE X CL:FIXNUM)
  (CL:RETURN-FROM EVEN? (CL:NOT (CL:LOGBITP 0 X))))

;;; (DEFUN (ODD? BOOLEAN) ...)

(CL:DEFUN ODD? (X)
  "Return true if `x' is an odd number."
  (CL:DECLARE (CL:TYPE CL:FIXNUM X))
  #+MCL
  (CL:CHECK-TYPE X CL:FIXNUM)
  (CL:RETURN-FROM ODD? (CL:LOGBITP 0 X)))

;;; (DEFUN (DIV INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) DIV))
(CL:DEFUN DIV (X Y)
  "Return the integer quotient from dividing `x' by `y'."
  (CL:DECLARE (CL:TYPE CL:FIXNUM X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE Y CL:FIXNUM)
  (CL:RETURN-FROM DIV (CL:VALUES (CL:TRUNCATE X Y))))

;;; (DEFUN (REM INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) REM))
(CL:DEFUN REM (X Y)
  "Return the remainder from dividing `x' by `y'.  The
sign of the result is always the same as the sign of `x'.  This has slightly
different behavior than the `mod' function, and has less overhead in C++ and
Java, which don't have direct support for a true modulus function."
  (CL:DECLARE (CL:TYPE CL:FIXNUM X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE Y CL:FIXNUM)
  (CL:RETURN-FROM REM (CL:REM X Y)))

;;; (DEFUN (FREM FLOAT) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT)
  FREM))
(CL:DEFUN FREM (X Y)
  "Return the floating point remainder from dividing `x' by `y'.  The
sign of the result is always the same as the sign of `x'.  This has slightly
different behavior than the `mod' function, and has less overhead in C++ and
Java, which don't have direct support for a true modulus function."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:DOUBLE-FLOAT)
  #+MCL
  (CL:CHECK-TYPE Y CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM FREM (CL:REM X Y)))

;;; (DEFUN (MOD INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) MOD))
(CL:DEFUN MOD (X MODULUS)
  "True modulus.  Return the result of `x' mod `modulo'.
Note: In C++ and Java, `mod' has more overhead than the similar
function `rem'.  The  answers returned by `mod' and `rem' are only
different when the signs of `x' and `modulo' are different."
  (CL:DECLARE (CL:TYPE CL:FIXNUM X MODULUS))
  #+MCL
  (CL:CHECK-TYPE X CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE MODULUS CL:FIXNUM)
  (CL:LET* ((REMAINDER (CL:MOD X MODULUS))) (CL:RETURN-FROM MOD REMAINDER)))

;;; (DEFUN (FMOD FLOAT) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT)
  FMOD))
(CL:DEFUN FMOD (X MODULUS)
  "True modulus for floats.  Return the result of `x' mod `modulo'.
Note: In C++ and Java, `mod' has more overhead than the similar
function `rem'.  The  answers returned by `mod' and `rem' are only
different when the signs of `x' and `modulo' are different."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT X MODULUS))
  #+MCL
  (CL:CHECK-TYPE X CL:DOUBLE-FLOAT)
  #+MCL
  (CL:CHECK-TYPE MODULUS CL:DOUBLE-FLOAT)
  (CL:LET* ((REMAINDER (CL:MOD X MODULUS))) (CL:RETURN-FROM FMOD REMAINDER)))

;;; (DEFUN (GCD INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) GCD))
(CL:DEFUN GCD (X Y)
  "Return the greatest common divisor of `x' and `y'."
  (CL:DECLARE (CL:TYPE CL:FIXNUM X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE Y CL:FIXNUM)
  (CL:WHEN (CL:< X 0) (CL:SETQ X (CL:- 0 X)))
  (CL:WHEN (CL:< Y 0) (CL:SETQ Y (CL:- 0 Y)))
  (CL:LET* ((TEMP 0)) (CL:DECLARE (CL:TYPE CL:FIXNUM TEMP))
   (CL:LOOP WHILE (CL:NOT (CL:= Y 0)) DO
    (CL:SETQ TEMP (CL:THE CL:FIXNUM (CL:REM X Y))) (CL:SETQ X Y)
    (CL:SETQ Y TEMP))
   (CL:RETURN-FROM GCD X)))

;;; (DEFUN (INTEGER-VALUED? BOOLEAN) ...)

(CL:DEFUN INTEGER-VALUED? (X)
  "Returns `true' if `x' is the floating point representation of an integer."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT X))
  #+MCL
  (CL:CHECK-TYPE X CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM INTEGER-VALUED? (CL:ZEROP (CL:REM X 1.0d0))))

;;; (DEFUN (FLOAT-TO-BASE60 (CONS OF NUMBER-WRAPPER)) ...)

(CL:DEFUN FLOAT-TO-BASE60 (X ALL-INTEGERS?)
  "Returns a cons of `x' in a base-60 form.  That means
the first value will be the integer part of `x', the next value
the iteger value of the fraction part of `x' times 60 and the
third value the fraction part of `x' time 3600.  If `all-integers?'
is `true', then the last value will be rounded to an integer.
This can be used to convert from decimal degree values to Degree-Minute-Second
or from decimal hours to Hour-Minute-Second format."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT X))
  #+MCL
  (CL:CHECK-TYPE X CL:DOUBLE-FLOAT)
  (CL:LET*
   ((DEGREE (FLOOR X)) (MINUTE (FLOOR (CL:* (CL:- X DEGREE) 60.0d0)))
    (FSECOND
     (CL:- (CL:* X 3600.0d0) (CL:* DEGREE 3600.0d0) (CL:* MINUTE 60.0d0))))
   (CL:DECLARE (CL:TYPE CL:FIXNUM DEGREE MINUTE)
    (CL:TYPE CL:DOUBLE-FLOAT FSECOND))
   (CL:IF ALL-INTEGERS?
    (CL:RETURN-FROM FLOAT-TO-BASE60
     (CONS-LIST (WRAP-INTEGER DEGREE) (WRAP-INTEGER MINUTE)
      (WRAP-INTEGER (ROUND FSECOND))))
    (CL:RETURN-FROM FLOAT-TO-BASE60
     (CONS-LIST (WRAP-INTEGER DEGREE) (WRAP-INTEGER MINUTE)
      (WRAP-FLOAT FSECOND))))))

;;; (DEFUN (BASE60-TO-FLOAT FLOAT) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:T) CL:DOUBLE-FLOAT) BASE60-TO-FLOAT))
(CL:DEFUN BASE60-TO-FLOAT (L)
  "Converts (x y z) into a float.  The return value
is x + y/60 + z/3600.
This can be used to convert from Degree-Minute-Second to decimal degrees
or from Hour-Minute-Second format to decimal hours."
  (CL:LET*
   ((DVALUE (%%VALUE L)) (MVALUE (%%VALUE (%%REST L)))
    (SVALUE (%%VALUE (%%REST (%%REST L)))) (D 0.0d0))
   (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT D))
   (CL:LET* ((TEST-VALUE-000 (SAFE-PRIMARY-TYPE DVALUE)))
    (CL:COND
     ((SUBTYPE-OF-FLOAT? TEST-VALUE-000)
      (CL:PROGN (CL:SETQ D (%WRAPPER-VALUE DVALUE))))
     ((SUBTYPE-OF-INTEGER? TEST-VALUE-000)
      (CL:PROGN (CL:SETQ D (NUMBER-WRAPPER-TO-FLOAT DVALUE))))
     (CL:T
      (CL:LET* ((STREAM-000 (NEW-OUTPUT-STRING-STREAM)))
       (%%PRINT-STREAM (%NATIVE-STREAM STREAM-000) "`" TEST-VALUE-000
        "' is not a valid case option")
       (CL:ERROR (NEW-STELLA-EXCEPTION (THE-STRING-READER STREAM-000)))))))
   (CL:LET* ((TEST-VALUE-001 (SAFE-PRIMARY-TYPE MVALUE)))
    (CL:COND
     ((SUBTYPE-OF-FLOAT? TEST-VALUE-001)
      (CL:PROGN (CL:SETQ D (CL:+ D (CL:/ (%WRAPPER-VALUE MVALUE) 60.0d0)))))
     ((SUBTYPE-OF-INTEGER? TEST-VALUE-001)
      (CL:PROGN (CL:SETQ D (CL:+ D (CL:/ (%WRAPPER-VALUE MVALUE) 60.0d0)))))
     (CL:T
      (CL:LET* ((STREAM-001 (NEW-OUTPUT-STRING-STREAM)))
       (%%PRINT-STREAM (%NATIVE-STREAM STREAM-001) "`" TEST-VALUE-001
        "' is not a valid case option")
       (CL:ERROR (NEW-STELLA-EXCEPTION (THE-STRING-READER STREAM-001)))))))
   (CL:LET* ((TEST-VALUE-002 (SAFE-PRIMARY-TYPE SVALUE)))
    (CL:COND
     ((SUBTYPE-OF-FLOAT? TEST-VALUE-002)
      (CL:PROGN (CL:SETQ D (CL:+ D (CL:/ (%WRAPPER-VALUE SVALUE) 3600.0d0)))))
     ((SUBTYPE-OF-INTEGER? TEST-VALUE-002)
      (CL:PROGN (CL:SETQ D (CL:+ D (CL:/ (%WRAPPER-VALUE SVALUE) 3600.0d0)))))
     (CL:T
      (CL:LET* ((STREAM-002 (NEW-OUTPUT-STRING-STREAM)))
       (%%PRINT-STREAM (%NATIVE-STREAM STREAM-002) "`" TEST-VALUE-002
        "' is not a valid case option")
       (CL:ERROR (NEW-STELLA-EXCEPTION (THE-STRING-READER STREAM-002)))))))
   (CL:RETURN-FROM BASE60-TO-FLOAT D)))

;;; (DEFUN (RANDOM INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM) CL:FIXNUM) RANDOM))
(CL:DEFUN RANDOM (N)
  "Generate a random integer in the interval [0..n-1]."
  (CL:DECLARE (CL:TYPE CL:FIXNUM N))
  #+MCL
  (CL:CHECK-TYPE N CL:FIXNUM)
  (CL:LET* ((RNUM (CL:RANDOM N))) (CL:DECLARE (CL:TYPE CL:FIXNUM RNUM))
   (CL:RETURN-FROM RANDOM RNUM)))

;;; (DEFUN SEED-RANDOM-NUMBER-GENERATOR ...)

(CL:DEFUN SEED-RANDOM-NUMBER-GENERATOR ()
  "Seeds the random number generator with the current time."
  :VOID)

;;; (DEFUN (SQRT FLOAT) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT) SQRT))
(CL:DEFUN SQRT (N)
  "Return the square root of `n'."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT N))
  #+MCL
  (CL:CHECK-TYPE N CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM SQRT (CL:SQRT N)))

;;; (DEFUN (COS FLOAT) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT) COS))
(CL:DEFUN COS (N)
  "Return the cosine of `n' radians."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT N))
  #+MCL
  (CL:CHECK-TYPE N CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM COS (CL:COS N)))

;;; (DEFUN (SIN FLOAT) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT) SIN))
(CL:DEFUN SIN (N)
  "Return the sine of `n' radians."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT N))
  #+MCL
  (CL:CHECK-TYPE N CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM SIN (CL:SIN N)))

;;; (DEFUN (TAN FLOAT) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT) TAN))
(CL:DEFUN TAN (N)
  "Return the tangent of `n' radians."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT N))
  #+MCL
  (CL:CHECK-TYPE N CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM TAN (CL:TAN N)))

;;; (DEFUN (ACOS FLOAT) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT) ACOS))
(CL:DEFUN ACOS (N)
  "Return the arccosine of `n' in radians."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT N))
  #+MCL
  (CL:CHECK-TYPE N CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM ACOS (CL:ACOS N)))

;;; (DEFUN (ASIN FLOAT) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT) ASIN))
(CL:DEFUN ASIN (N)
  "Return the arcsine of `n' in radians."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT N))
  #+MCL
  (CL:CHECK-TYPE N CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM ASIN (CL:ASIN N)))

;;; (DEFUN (ATAN FLOAT) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT) ATAN))
(CL:DEFUN ATAN (N)
  "Return the arc tangent of `n' in radians."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT N))
  #+MCL
  (CL:CHECK-TYPE N CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM ATAN (CL:ATAN N)))

;;; (DEFUN (ATAN2 FLOAT) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT)
  ATAN2))
(CL:DEFUN ATAN2 (X Y)
  "Return the arc tangent of `x' / `y' in radians."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:DOUBLE-FLOAT)
  #+MCL
  (CL:CHECK-TYPE Y CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM ATAN2 (CL:ATAN X Y)))

;;; (DEFCONSTANT RECIPROCAL-NL10 ...)

(CL:DEFVAR RECIPROCAL-NL10 NULL-FLOAT
  "1 / (log 10) Reciprocal of the Log base e of 10.
Used for log 10 conversions.")
(CL:DECLAIM (CL:TYPE CL:DOUBLE-FLOAT RECIPROCAL-NL10))

;;; (DEFUN (LOG FLOAT) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT) LOG))
(CL:DEFUN LOG (N)
  "Return the natural logarithm (base e) of `n'."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT N))
  #+MCL
  (CL:CHECK-TYPE N CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM LOG (CL:LOG N)))

;;; (DEFUN (LOG10 FLOAT) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT) LOG10))
(CL:DEFUN LOG10 (N)
  "Return the logarithm (base 10) of `n'."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT N))
  #+MCL
  (CL:CHECK-TYPE N CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM LOG10 (CL:LOG N 10.0D0)))

;;; (DEFUN (EXP FLOAT) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT) EXP))
(CL:DEFUN EXP (N)
  "Return the e to the power `n'."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT N))
  #+MCL
  (CL:CHECK-TYPE N CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM EXP (CL:EXP N)))

;;; (DEFUN (EXPT FLOAT) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:DOUBLE-FLOAT CL:DOUBLE-FLOAT) CL:DOUBLE-FLOAT)
  EXPT))
(CL:DEFUN EXPT (X Y)
  "Return `x' ^ `y'."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:DOUBLE-FLOAT)
  #+MCL
  (CL:CHECK-TYPE Y CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM EXPT (CL:EXPT X Y)))

;;; (DEFUN (MIN INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) MIN))
(CL:DEFUN MIN (X Y)
  "Return the minimum of `x' and `y'.  If either is NULL, return the other."
  (CL:DECLARE (CL:TYPE CL:FIXNUM X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE Y CL:FIXNUM)
  (CL:WHEN (NULL? X) (CL:RETURN-FROM MIN Y))
  (CL:WHEN (NULL? Y) (CL:RETURN-FROM MIN X))
  (CL:RETURN-FROM MIN (CL:IF (CL:< X Y) X Y)))

;;; (DEFUN (MAX INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) MAX))
(CL:DEFUN MAX (X Y)
  "Return the maximum of `x' and `y'.  If either is NULL, return the other."
  (CL:DECLARE (CL:TYPE CL:FIXNUM X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE Y CL:FIXNUM)
  (CL:WHEN (NULL? X) (CL:RETURN-FROM MAX Y))
  (CL:WHEN (NULL? Y) (CL:RETURN-FROM MAX X))
  (CL:RETURN-FROM MAX (CL:IF (CL:> X Y) X Y)))

;;; (DEFMETHOD (ABS INTEGER) ...)

(CL:DEFMETHOD ABS ((X CL:INTEGER))
  "Return the absolute value of `x'."
  (CL:DECLARE (CL:TYPE CL:FIXNUM X))
  #+MCL
  (CL:CHECK-TYPE X CL:FIXNUM)
  (CL:RETURN-FROM ABS (CL:IF (CL:< X 0) (CL:- 0 X) X)))

;;; (DEFMETHOD (ABS FLOAT) ...)

(CL:DEFMETHOD ABS ((X CL:FLOAT))
  "Return the absolute value of `x'."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT X))
  #+MCL
  (CL:CHECK-TYPE X CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM ABS (CL:IF (CL:< X 0.0d0) (CL:- 0.0d0 X) X)))

;;; (DEFUN (CHARACTER-CODE INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:T) CL:FIXNUM) CHARACTER-CODE))
(CL:DEFUN CHARACTER-CODE (CH)
  "Return the 8-bit ASCII code of `ch' as an integer."
  (CL:RETURN-FROM CHARACTER-CODE (CL:CHAR-CODE CH)))

;;; (DEFUN (CODE-CHARACTER CHARACTER) ...)

(CL:DEFUN CODE-CHARACTER (CODE)
  "Return the character encoded by `code' (0 <= `code' <= 255)."
  (CL:DECLARE (CL:TYPE CL:FIXNUM CODE))
  #+MCL
  (CL:CHECK-TYPE CODE CL:FIXNUM)
  (CL:RETURN-FROM CODE-CHARACTER (CL:CODE-CHAR CODE)))

;;; (DEFUN (CHARACTER-DOWNCASE CHARACTER) ...)

(CL:DEFUN CHARACTER-DOWNCASE (CH)
  "If `ch' is lowercase, return its uppercase version,
otherwise, return 'ch' unmodified."
  (CL:RETURN-FROM CHARACTER-DOWNCASE
   (CL:LET
    ((SELF *CHARACTER-DOWNCASE-TABLE*)
     (POSITION (CL:THE CL:FIXNUM (CL:CHAR-CODE CH))))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFUN (CHARACTER-UPCASE CHARACTER) ...)

(CL:DEFUN CHARACTER-UPCASE (CH)
  "If `ch' is uppercase, return its lowercase version,
otherwise, return 'ch' unmodified.  If only the first character of
a sequence of characters is to be capitalized, `character-capitalize'
should be used instead."
  (CL:RETURN-FROM CHARACTER-UPCASE
   (CL:LET
    ((SELF *CHARACTER-UPCASE-TABLE*)
     (POSITION (CL:THE CL:FIXNUM (CL:CHAR-CODE CH))))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFUN (CHARACTER-CAPITALIZE CHARACTER) ...)

(CL:DEFUN CHARACTER-CAPITALIZE (CH)
  "Return the capitalized character for `ch'.  This is generally the same
as the uppercase character, except for obscure non-English characters in Java.  It should
be used if only the first character of a sequence of characters is to be capitalized."
  (CL:RETURN-FROM CHARACTER-CAPITALIZE
   (CL:LET
    ((SELF *CHARACTER-UPCASE-TABLE*)
     (POSITION (CL:THE CL:FIXNUM (CL:CHAR-CODE CH))))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFSPECIAL *TRANSIENTOBJECTS?* ...)

(CL:DEFVAR *TRANSIENTOBJECTS?* CL:NIL)

;;; (DEFUN (STRING-EQL? BOOLEAN) ...)

(CL:DEFUN STRING-EQL? (X Y)
  "Return true if `x' and `y' are equal strings or are both undefined.  This
test is substituted automatically by the STELLA translator if `eql?' is applied
to strings."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE Y CL:SIMPLE-STRING)
  (CL:IF (CL:EQ X STELLA::NULL-STRING)
   (CL:RETURN-FROM STRING-EQL? (CL:EQ Y STELLA::NULL-STRING))
   (CL:RETURN-FROM STRING-EQL?
    (CL:AND (CL:NOT (CL:EQ Y STELLA::NULL-STRING)) (CL:string= x y)))))

;;; (DEFUN (STRING-EQUAL? BOOLEAN) ...)

(CL:DEFUN STRING-EQUAL? (X Y)
  "Return true if `x' and `y' are equal strings ignoring character case or
are both undefined."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE Y CL:SIMPLE-STRING)
  (CL:IF (CL:EQ X STELLA::NULL-STRING)
   (CL:RETURN-FROM STRING-EQUAL? (CL:EQ Y STELLA::NULL-STRING))
   (CL:RETURN-FROM STRING-EQUAL?
    (CL:AND (CL:NOT (CL:EQ Y STELLA::NULL-STRING)) (CL:string-equal x y)))))

;;; (DEFUN (STRING-COMPARE INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:SIMPLE-STRING CL:SIMPLE-STRING CL:T) CL:FIXNUM)
  STRING-COMPARE))
(CL:DEFUN STRING-COMPARE (X Y CASE-SENSITIVE?)
  "Compare `x' and `y' lexicographically, and return -1, 0, 
or 1, depending on whether `x' is less than, equal, or greater than `y'.
If `case-sensitive?' is true, then case does matter for the comparison"
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE Y CL:SIMPLE-STRING)
  (CL:IF CASE-SENSITIVE?
   (CL:RETURN-FROM STRING-COMPARE
    (CL:COND ((CL:STRING< X Y) -1) ((CL:STRING> X Y) 1) (CL:T 0)))
   (CL:RETURN-FROM STRING-COMPARE
    (CL:COND ((CL:STRING-LESSP X Y) -1) ((CL:STRING-GREATERP X Y) 1)
     (CL:T 0)))))

;;; (DEFMETHOD (EMPTY? BOOLEAN) ...)

(CL:DEFMETHOD EMPTY? ((X CL:STRING))
  "Return true if `x' is the empty string \"\""
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  (CL:RETURN-FROM EMPTY? (STRING-EQL? X "")))

;;; (DEFMETHOD (NON-EMPTY? BOOLEAN) ...)

(CL:DEFMETHOD NON-EMPTY? ((X CL:STRING))
  "Return true if `x' is not the empty string \"\""
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  (CL:RETURN-FROM NON-EMPTY? (CL:NOT (STRING-EQL? X ""))))

;;; (DEFMETHOD (EMPTY? BOOLEAN) ...)

(CL:DEFMETHOD EMPTY? ((X STRING-WRAPPER))
  "Return true if `x' is the wrapped empty string \"\""
  (CL:RETURN-FROM EMPTY? (STRING-EQL? (%WRAPPER-VALUE X) "")))

;;; (DEFMETHOD (NON-EMPTY? BOOLEAN) ...)

(CL:DEFMETHOD NON-EMPTY? ((X STRING-WRAPPER))
  "Return true if `x' is not the wrapped empty string \"\""
  (CL:RETURN-FROM NON-EMPTY? (CL:NOT (STRING-EQL? (%WRAPPER-VALUE X) ""))))

;;; (DEFUN (STRING< BOOLEAN) ...)

(CL:DEFUN STRING< (X Y)
  "Return true if `x' is lexicographically < `y', considering case."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE Y CL:SIMPLE-STRING)
  (CL:RETURN-FROM STRING< (CL:NULL (CL:STRING>= X Y))))

;;; (DEFUN (STRING<= BOOLEAN) ...)

(CL:DEFUN STRING<= (X Y)
  "Return true if `x' is lexicographically <= `y', considering case."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE Y CL:SIMPLE-STRING)
  (CL:RETURN-FROM STRING<= (CL:NULL (CL:STRING> X Y))))

;;; (DEFUN (STRING>= BOOLEAN) ...)

(CL:DEFUN STRING>= (X Y)
  "Return true if `x' is lexicographically >= `y', considering case."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE Y CL:SIMPLE-STRING)
  (CL:RETURN-FROM STRING>= (CL:NULL (CL:STRING< X Y))))

;;; (DEFUN (STRING> BOOLEAN) ...)

(CL:DEFUN STRING> (X Y)
  "Return true if `x' is lexicographically > `y', considering case."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE Y CL:SIMPLE-STRING)
  (CL:RETURN-FROM STRING> (CL:NULL (CL:STRING<= X Y))))

;;; (DEFUN (STRING-LESS? BOOLEAN) ...)

(CL:DEFUN STRING-LESS? (X Y)
  "Return true if `x' is lexicographically < `y', ignoring case."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE Y CL:SIMPLE-STRING)
  (CL:RETURN-FROM STRING-LESS? (CL:NULL (CL:STRING-NOT-LESSP X Y))))

;;; (DEFUN (STRING-LESS-EQUAL? BOOLEAN) ...)

(CL:DEFUN STRING-LESS-EQUAL? (X Y)
  "Return true if `x' is lexicographically <= `y', ignoring case."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE Y CL:SIMPLE-STRING)
  (CL:RETURN-FROM STRING-LESS-EQUAL? (CL:NULL (CL:STRING-GREATERP X Y))))

;;; (DEFUN (STRING-GREATER-EQUAL? BOOLEAN) ...)

(CL:DEFUN STRING-GREATER-EQUAL? (X Y)
  "Return true if `x' is lexicographically >= `y', ignoring case."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE Y CL:SIMPLE-STRING)
  (CL:RETURN-FROM STRING-GREATER-EQUAL? (CL:NULL (CL:STRING-LESSP X Y))))

;;; (DEFUN (STRING-GREATER? BOOLEAN) ...)

(CL:DEFUN STRING-GREATER? (X Y)
  "Return true if `x' is lexicographically > `y', ignoring case."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING X Y))
  #+MCL
  (CL:CHECK-TYPE X CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE Y CL:SIMPLE-STRING)
  (CL:RETURN-FROM STRING-GREATER? (CL:NULL (CL:STRING-NOT-GREATERP X Y))))

;;; (DEFUN (MAKE-MUTABLE-STRING MUTABLE-STRING) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:T) CL:SIMPLE-STRING)
  MAKE-MUTABLE-STRING))
(CL:DEFUN MAKE-MUTABLE-STRING (SIZE INITCHAR)
  "Return a new mutable string filled with `size' `initchar's."
  (CL:DECLARE (CL:TYPE CL:FIXNUM SIZE))
  #+MCL
  (CL:CHECK-TYPE SIZE CL:FIXNUM)
  (CL:RETURN-FROM MAKE-MUTABLE-STRING
   (CL:MAKE-STRING SIZE :INITIAL-ELEMENT INITCHAR)))

;;; (DEFUN (MAKE-RAW-MUTABLE-STRING MUTABLE-STRING) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:FIXNUM) CL:SIMPLE-STRING) MAKE-RAW-MUTABLE-STRING))
(CL:DEFUN MAKE-RAW-MUTABLE-STRING (SIZE)
  "Return a new uninitialized mutable string of `size'."
  (CL:DECLARE (CL:TYPE CL:FIXNUM SIZE))
  #+MCL
  (CL:CHECK-TYPE SIZE CL:FIXNUM)
  (CL:LET* ((S STELLA::NULL-STRING)) (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING S))
   (SETQ S (CL:MAKE-STRING SIZE)) (CL:RETURN-FROM MAKE-RAW-MUTABLE-STRING S)))

;;; (DEFMETHOD (CONCATENATE STRING) ...)

(CL:DEFMETHOD CONCATENATE ((STRING1 CL:STRING) STRING2 CL:&REST OTHERSTRINGS)
  "Return a new string representing the concatenation
of `string1', `string2', and `otherStrings'.  The two mandatory parameters
allow us to optimize the common binary case by not relying on the somewhat
less efficient variable arguments mechanism."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING STRING1 STRING2))
  #+MCL
  (CL:CHECK-TYPE STRING1 CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE STRING2 CL:SIMPLE-STRING)
  (CL:WHEN (CL:= (CL:LENGTH OTHERSTRINGS) 0)
   (CL:RETURN-FROM CONCATENATE (STRING-CONCATENATE STRING1 STRING2)))
  (CL:LET*
   ((RESULT STELLA::NULL-STRING)
    (LENGTH
     (CL:+ (CL:THE CL:FIXNUM (CL:LENGTH STRING1))
      (CL:THE CL:FIXNUM (CL:LENGTH STRING2))))
    (INDEX 0))
   (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING RESULT)
    (CL:TYPE CL:FIXNUM LENGTH INDEX))
   (CL:LET* ((STRING STELLA::NULL-STRING) (ITER-000 OTHERSTRINGS))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING STRING))
    (CL:LOOP WHILE ITER-000 DO (CL:SETQ STRING (CL:POP ITER-000))
     (CL:SETQ LENGTH (CL:+ LENGTH (CL:THE CL:FIXNUM (CL:LENGTH STRING))))))
   (CL:SETQ RESULT (MAKE-RAW-MUTABLE-STRING LENGTH))
   (CL:LET*
    ((CH NULL-CHARACTER) (VECTOR-000 STRING1) (INDEX-000 0)
     (LENGTH-000 (CL:THE CL:FIXNUM (CL:LENGTH VECTOR-000))))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING VECTOR-000)
     (CL:TYPE CL:FIXNUM INDEX-000 LENGTH-000))
    (CL:LOOP WHILE (CL:< INDEX-000 LENGTH-000) DO
     (CL:SETQ CH
      (CL:LET ((SELF VECTOR-000) (POSITION INDEX-000))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
        (CL:TYPE CL:FIXNUM POSITION))
       (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))))
     (CL:LET ((SELF RESULT) (CH CH) (POSITION INDEX))
      (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
       (CL:TYPE CL:FIXNUM POSITION))
      (SETF
       (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
       (CL:THE CL:CHARACTER CH)))
     (CL:SETQ INDEX (CL:1+ INDEX)) (CL:SETQ INDEX-000 (CL:1+ INDEX-000))))
   (CL:LET*
    ((CH NULL-CHARACTER) (VECTOR-001 STRING2) (INDEX-001 0)
     (LENGTH-001 (CL:THE CL:FIXNUM (CL:LENGTH VECTOR-001))))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING VECTOR-001)
     (CL:TYPE CL:FIXNUM INDEX-001 LENGTH-001))
    (CL:LOOP WHILE (CL:< INDEX-001 LENGTH-001) DO
     (CL:SETQ CH
      (CL:LET ((SELF VECTOR-001) (POSITION INDEX-001))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
        (CL:TYPE CL:FIXNUM POSITION))
       (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))))
     (CL:LET ((SELF RESULT) (CH CH) (POSITION INDEX))
      (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
       (CL:TYPE CL:FIXNUM POSITION))
      (SETF
       (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
       (CL:THE CL:CHARACTER CH)))
     (CL:SETQ INDEX (CL:1+ INDEX)) (CL:SETQ INDEX-001 (CL:1+ INDEX-001))))
   (CL:LET* ((STRING STELLA::NULL-STRING) (ITER-001 OTHERSTRINGS))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING STRING))
    (CL:LOOP WHILE ITER-001 DO (CL:SETQ STRING (CL:POP ITER-001))
     (CL:LET*
      ((CH NULL-CHARACTER) (VECTOR-002 STRING) (INDEX-002 0)
       (LENGTH-002 (CL:THE CL:FIXNUM (CL:LENGTH VECTOR-002))))
      (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING VECTOR-002)
       (CL:TYPE CL:FIXNUM INDEX-002 LENGTH-002))
      (CL:LOOP WHILE (CL:< INDEX-002 LENGTH-002) DO
       (CL:SETQ CH
        (CL:LET ((SELF VECTOR-002) (POSITION INDEX-002))
         (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
          (CL:TYPE CL:FIXNUM POSITION))
         (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
          (CL:THE CL:FIXNUM POSITION))))
       (CL:LET ((SELF RESULT) (CH CH) (POSITION INDEX))
        (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
         (CL:TYPE CL:FIXNUM POSITION))
        (SETF
         (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
         (CL:THE CL:CHARACTER CH)))
       (CL:SETQ INDEX (CL:1+ INDEX)) (CL:SETQ INDEX-002 (CL:1+ INDEX-002))))))
   (CL:RETURN-FROM CONCATENATE
    (CL:LET ((S RESULT)) (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING S))
     (CL:THE CL:SIMPLE-STRING S)))))

;;; (DEFUN (HELP-SUBSTITUTE-CHARACTERS MUTABLE-STRING) ...)

(CL:DECLAIM
 (CL:FTYPE
  (CL:FUNCTION (CL:SIMPLE-STRING CL:SIMPLE-STRING CL:SIMPLE-STRING)
   CL:SIMPLE-STRING)
  HELP-SUBSTITUTE-CHARACTERS))
(CL:DEFUN HELP-SUBSTITUTE-CHARACTERS (SELF NEW-CHARS OLD-CHARS)
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF NEW-CHARS OLD-CHARS))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE NEW-CHARS CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE OLD-CHARS CL:SIMPLE-STRING)
  (CL:LET* ((POS NULL-INTEGER)) (CL:DECLARE (CL:TYPE CL:FIXNUM POS))
   (CL:LET*
    ((I NULL-INTEGER) (ITER-000 0)
     (UPPER-BOUND-000 (CL:1- (CL:THE CL:FIXNUM (CL:LENGTH SELF)))))
    (CL:DECLARE (CL:TYPE CL:FIXNUM I ITER-000 UPPER-BOUND-000))
    (CL:LOOP WHILE (CL:<= ITER-000 UPPER-BOUND-000) DO (CL:SETQ I ITER-000)
     (CL:SETQ POS
      (POSITION OLD-CHARS
       (CL:LET ((SELF SELF) (POSITION I))
        (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
         (CL:TYPE CL:FIXNUM POSITION))
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))
       0))
     (CL:WHEN (DEFINED? POS)
      (CL:LET
       ((SELF SELF)
        (CH
         (CL:LET ((SELF NEW-CHARS) (POSITION POS))
          (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
           (CL:TYPE CL:FIXNUM POSITION))
          (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
           (CL:THE CL:FIXNUM POSITION))))
        (POSITION I))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
        (CL:TYPE CL:FIXNUM POSITION))
       (SETF
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
        (CL:THE CL:CHARACTER CH))))
     (CL:SETQ ITER-000 (CL:1+ ITER-000))))
   (CL:RETURN-FROM HELP-SUBSTITUTE-CHARACTERS SELF)))

;;; (DEFMETHOD (SUBSTITUTE-CHARACTERS MUTABLE-STRING) ...)

(CL:DEFMETHOD SUBSTITUTE-CHARACTERS ((SELF CL:STRING) NEW-CHARS OLD-CHARS)
  "Substitute all occurences of of a member of `old-chars' with the 
corresponding member of `new-chars' in the string `self'.  IMPORTANT:  The return
value should be used instead of relying on destructive substitution, since the
substitution will not be destructive in all translated languages."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF NEW-CHARS OLD-CHARS))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE NEW-CHARS CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE OLD-CHARS CL:SIMPLE-STRING)
  (CL:RETURN-FROM SUBSTITUTE-CHARACTERS
   (HELP-SUBSTITUTE-CHARACTERS SELF NEW-CHARS OLD-CHARS)))

;;; (DEFMETHOD (SUBSTITUTE-CHARACTERS STRING) ...)

(CL:DEFMETHOD SUBSTITUTE-CHARACTERS ((SELF CL:STRING) NEW-CHARS OLD-CHARS)
  "Substitute all occurences of of a member of `old-chars' with the 
corresponding member of `new-chars' in the string `self'.  Returns a new string."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF NEW-CHARS OLD-CHARS))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE NEW-CHARS CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE OLD-CHARS CL:SIMPLE-STRING)
  (CL:RETURN-FROM SUBSTITUTE-CHARACTERS
   (CL:LET
    ((S
      (HELP-SUBSTITUTE-CHARACTERS (CL:THE CL:SIMPLE-STRING (CL:COPY-SEQ SELF))
       NEW-CHARS OLD-CHARS)))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING S)) (CL:THE CL:SIMPLE-STRING S))))

;;; (DEFUN (REPLACE-SUBSTRINGS STRING) ...)

(CL:DECLAIM
 (CL:FTYPE
  (CL:FUNCTION (CL:SIMPLE-STRING CL:SIMPLE-STRING CL:SIMPLE-STRING)
   CL:SIMPLE-STRING)
  REPLACE-SUBSTRINGS))
(CL:DEFUN REPLACE-SUBSTRINGS (STRING NEW OLD)
  "Replace all occurrences of `old' in `string' with `new'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING STRING NEW OLD))
  #+MCL
  (CL:CHECK-TYPE STRING CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE NEW CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE OLD CL:SIMPLE-STRING)
  (CL:LET*
   ((STRINGLENGTH (CL:THE CL:FIXNUM (CL:LENGTH STRING)))
    (OLDLENGTH (CL:THE CL:FIXNUM (CL:LENGTH OLD)))
    (NEWLENGTH (CL:THE CL:FIXNUM (CL:LENGTH NEW))) (NOFOCCURRENCES 0)
    (OLDSTART 0) (CURSOR 0) (RESULTCURSOR 0) (RESULT STELLA::NULL-STRING))
   (CL:DECLARE
    (CL:TYPE CL:FIXNUM STRINGLENGTH OLDLENGTH NEWLENGTH NOFOCCURRENCES
     OLDSTART CURSOR RESULTCURSOR)
    (CL:TYPE CL:SIMPLE-STRING RESULT))
   (CL:LOOP WHILE
    (DEFINED? (CL:SETQ OLDSTART (STRING-SEARCH STRING OLD CURSOR))) DO
    (CL:SETQ NOFOCCURRENCES (CL:1+ NOFOCCURRENCES))
    (CL:SETQ CURSOR (CL:+ OLDSTART OLDLENGTH)))
   (CL:WHEN (CL:= NOFOCCURRENCES 0)
    (CL:RETURN-FROM REPLACE-SUBSTRINGS STRING))
   (CL:SETQ RESULT
    (MAKE-RAW-MUTABLE-STRING
     (CL:+ STRINGLENGTH (CL:* NOFOCCURRENCES (CL:- NEWLENGTH OLDLENGTH)))))
   (CL:SETQ CURSOR 0)
   (CL:LOOP WHILE
    (DEFINED? (CL:SETQ OLDSTART (STRING-SEARCH STRING OLD CURSOR))) DO
    (CL:LET*
     ((I NULL-INTEGER) (ITER-000 CURSOR) (UPPER-BOUND-000 (CL:1- OLDSTART)))
     (CL:DECLARE (CL:TYPE CL:FIXNUM I ITER-000 UPPER-BOUND-000))
     (CL:LOOP WHILE (CL:<= ITER-000 UPPER-BOUND-000) DO (CL:SETQ I ITER-000)
      (CL:LET
       ((SELF RESULT)
        (CH
         (CL:LET ((SELF STRING) (POSITION I))
          (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
           (CL:TYPE CL:FIXNUM POSITION))
          (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
           (CL:THE CL:FIXNUM POSITION))))
        (POSITION RESULTCURSOR))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
        (CL:TYPE CL:FIXNUM POSITION))
       (SETF
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
        (CL:THE CL:CHARACTER CH)))
      (CL:SETQ RESULTCURSOR (CL:1+ RESULTCURSOR))
      (CL:SETQ ITER-000 (CL:1+ ITER-000))))
    (CL:LET*
     ((CHAR NULL-CHARACTER) (VECTOR-000 NEW) (INDEX-000 0)
      (LENGTH-000 (CL:THE CL:FIXNUM (CL:LENGTH VECTOR-000))))
     (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING VECTOR-000)
      (CL:TYPE CL:FIXNUM INDEX-000 LENGTH-000))
     (CL:LOOP WHILE (CL:< INDEX-000 LENGTH-000) DO
      (CL:SETQ CHAR
       (CL:LET ((SELF VECTOR-000) (POSITION INDEX-000))
        (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
         (CL:TYPE CL:FIXNUM POSITION))
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
         (CL:THE CL:FIXNUM POSITION))))
      (CL:LET ((SELF RESULT) (CH CHAR) (POSITION RESULTCURSOR))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
        (CL:TYPE CL:FIXNUM POSITION))
       (SETF
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
        (CL:THE CL:CHARACTER CH)))
      (CL:SETQ RESULTCURSOR (CL:1+ RESULTCURSOR))
      (CL:SETQ INDEX-000 (CL:1+ INDEX-000))))
    (CL:SETQ CURSOR (CL:+ OLDSTART OLDLENGTH)))
   (CL:LET*
    ((I NULL-INTEGER) (ITER-001 CURSOR)
     (UPPER-BOUND-001 (CL:1- STRINGLENGTH)))
    (CL:DECLARE (CL:TYPE CL:FIXNUM I ITER-001 UPPER-BOUND-001))
    (CL:LOOP WHILE (CL:<= ITER-001 UPPER-BOUND-001) DO (CL:SETQ I ITER-001)
     (CL:LET
      ((SELF RESULT)
       (CH
        (CL:LET ((SELF STRING) (POSITION I))
         (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
          (CL:TYPE CL:FIXNUM POSITION))
         (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
          (CL:THE CL:FIXNUM POSITION))))
       (POSITION RESULTCURSOR))
      (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
       (CL:TYPE CL:FIXNUM POSITION))
      (SETF
       (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
       (CL:THE CL:CHARACTER CH)))
     (CL:SETQ RESULTCURSOR (CL:1+ RESULTCURSOR))
     (CL:SETQ ITER-001 (CL:1+ ITER-001))))
   (CL:RETURN-FROM REPLACE-SUBSTRINGS
    (CL:LET ((S RESULT)) (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING S))
     (CL:THE CL:SIMPLE-STRING S)))))

;;; (DEFUN (INSTANTIATE-STRING-TEMPLATE STRING) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:SIMPLE-STRING CL:T) CL:SIMPLE-STRING)
  INSTANTIATE-STRING-TEMPLATE))
(CL:DEFUN INSTANTIATE-STRING-TEMPLATE (TEMPLATE CL:&REST |VARS&VALUES|)
  "For each occurrence of a <var> string from `vars&values' in `template' replace it
with its corresponding <value> string.  Replacement is done in sequence which
means (part of) a value might be replaced further with a later <var> and <value>."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING TEMPLATE))
  #+MCL
  (CL:CHECK-TYPE TEMPLATE CL:SIMPLE-STRING)
  (CL:LET* ((VAR STELLA::NULL-STRING))
   (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING VAR))
   (CL:LET* ((ITEM STELLA::NULL-STRING) (ITER-000 |VARS&VALUES|))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING ITEM))
    (CL:LOOP WHILE ITER-000 DO (CL:SETQ ITEM (CL:POP ITER-000))
     (CL:COND
      ((CL:NOT (CL:EQ VAR STELLA::NULL-STRING))
       (CL:SETQ TEMPLATE (REPLACE-SUBSTRINGS TEMPLATE ITEM VAR))
       (CL:SETQ VAR STELLA::NULL-STRING))
      (CL:T (CL:SETQ VAR ITEM)))))
   (CL:RETURN-FROM INSTANTIATE-STRING-TEMPLATE TEMPLATE)))

;;; (DEFUN (INSERT-STRING INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE
  (CL:FUNCTION
   (CL:SIMPLE-STRING CL:FIXNUM CL:FIXNUM CL:SIMPLE-STRING CL:FIXNUM CL:T)
   CL:FIXNUM)
  INSERT-STRING))
(CL:DEFUN INSERT-STRING (SOURCE START END TARGET TARGET-INDEX CASE-CONVERSION)
  "Inserts characters from `source' begining at `start' and
ending at `end' into `target' starting at `target-index'.  If `end' is `null',
then the entire length of the string is used. The copy of characters is affected
by the `case-conversion' keyword which should be one of
   :UPCASE :DOWNCASE :CAPITALIZE :PRESERVE.

The final value of target-index is returned."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SOURCE TARGET)
   (CL:TYPE CL:FIXNUM START END TARGET-INDEX))
  #+MCL
  (CL:CHECK-TYPE SOURCE CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE END CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE TARGET CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE TARGET-INDEX CL:FIXNUM)
  (CL:WHEN (NULL? END)
   (CL:SETQ END (CL:1- (CL:THE CL:FIXNUM (CL:LENGTH SOURCE)))))
  (CL:WHEN (CL:< END START) (CL:RETURN-FROM INSERT-STRING TARGET-INDEX))
  (CL:COND
   ((CL:EQ CASE-CONVERSION KWD-PRIMAL-UPCASE)
    (CL:LET*
     ((J NULL-INTEGER) (ITER-000 START) (UPPER-BOUND-000 END)
      (UNBOUNDED?-000 (NULL? UPPER-BOUND-000)))
     (CL:DECLARE (CL:TYPE CL:FIXNUM J ITER-000 UPPER-BOUND-000))
     (CL:LOOP WHILE (CL:OR UNBOUNDED?-000 (CL:<= ITER-000 UPPER-BOUND-000)) DO
      (CL:SETQ J ITER-000)
      (CL:LET
       ((SELF TARGET)
        (CH
         (CL:LET
          ((SELF *CHARACTER-UPCASE-TABLE*)
           (POSITION
            (CL:THE CL:FIXNUM
             (CL:CHAR-CODE
              (CL:LET ((SELF SOURCE) (POSITION J))
               (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
                (CL:TYPE CL:FIXNUM POSITION))
               (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
                (CL:THE CL:FIXNUM POSITION)))))))
          (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
           (CL:TYPE CL:FIXNUM POSITION))
          (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
           (CL:THE CL:FIXNUM POSITION))))
        (POSITION TARGET-INDEX))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
        (CL:TYPE CL:FIXNUM POSITION))
       (SETF
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
        (CL:THE CL:CHARACTER CH)))
      (CL:SETQ TARGET-INDEX (CL:1+ TARGET-INDEX))
      (CL:SETQ ITER-000 (CL:1+ ITER-000)))))
   ((CL:EQ CASE-CONVERSION KWD-PRIMAL-DOWNCASE)
    (CL:LET*
     ((J NULL-INTEGER) (ITER-001 START) (UPPER-BOUND-001 END)
      (UNBOUNDED?-001 (NULL? UPPER-BOUND-001)))
     (CL:DECLARE (CL:TYPE CL:FIXNUM J ITER-001 UPPER-BOUND-001))
     (CL:LOOP WHILE (CL:OR UNBOUNDED?-001 (CL:<= ITER-001 UPPER-BOUND-001)) DO
      (CL:SETQ J ITER-001)
      (CL:LET
       ((SELF TARGET)
        (CH
         (CL:LET
          ((SELF *CHARACTER-DOWNCASE-TABLE*)
           (POSITION
            (CL:THE CL:FIXNUM
             (CL:CHAR-CODE
              (CL:LET ((SELF SOURCE) (POSITION J))
               (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
                (CL:TYPE CL:FIXNUM POSITION))
               (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
                (CL:THE CL:FIXNUM POSITION)))))))
          (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
           (CL:TYPE CL:FIXNUM POSITION))
          (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
           (CL:THE CL:FIXNUM POSITION))))
        (POSITION TARGET-INDEX))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
        (CL:TYPE CL:FIXNUM POSITION))
       (SETF
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
        (CL:THE CL:CHARACTER CH)))
      (CL:SETQ TARGET-INDEX (CL:1+ TARGET-INDEX))
      (CL:SETQ ITER-001 (CL:1+ ITER-001)))))
   ((CL:EQ CASE-CONVERSION KWD-PRIMAL-CAPITALIZE)
    (CL:LET
     ((SELF TARGET)
      (CH
       (CL:LET
        ((SELF *CHARACTER-UPCASE-TABLE*)
         (POSITION
          (CL:THE CL:FIXNUM
           (CL:CHAR-CODE
            (CL:LET ((SELF SOURCE) (POSITION START))
             (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
              (CL:TYPE CL:FIXNUM POSITION))
             (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
              (CL:THE CL:FIXNUM POSITION)))))))
        (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
         (CL:TYPE CL:FIXNUM POSITION))
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
         (CL:THE CL:FIXNUM POSITION))))
      (POSITION TARGET-INDEX))
     (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
     (SETF
      (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
      (CL:THE CL:CHARACTER CH)))
    (CL:SETQ TARGET-INDEX (CL:1+ TARGET-INDEX))
    (CL:LET*
     ((J NULL-INTEGER) (ITER-002 (CL:1+ START)) (UPPER-BOUND-002 END)
      (UNBOUNDED?-002 (NULL? UPPER-BOUND-002)))
     (CL:DECLARE (CL:TYPE CL:FIXNUM J ITER-002 UPPER-BOUND-002))
     (CL:LOOP WHILE (CL:OR UNBOUNDED?-002 (CL:<= ITER-002 UPPER-BOUND-002)) DO
      (CL:SETQ J ITER-002)
      (CL:LET
       ((SELF TARGET)
        (CH
         (CL:LET
          ((SELF *CHARACTER-DOWNCASE-TABLE*)
           (POSITION
            (CL:THE CL:FIXNUM
             (CL:CHAR-CODE
              (CL:LET ((SELF SOURCE) (POSITION J))
               (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
                (CL:TYPE CL:FIXNUM POSITION))
               (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
                (CL:THE CL:FIXNUM POSITION)))))))
          (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
           (CL:TYPE CL:FIXNUM POSITION))
          (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
           (CL:THE CL:FIXNUM POSITION))))
        (POSITION TARGET-INDEX))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
        (CL:TYPE CL:FIXNUM POSITION))
       (SETF
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
        (CL:THE CL:CHARACTER CH)))
      (CL:SETQ TARGET-INDEX (CL:1+ TARGET-INDEX))
      (CL:SETQ ITER-002 (CL:1+ ITER-002)))))
   ((CL:EQ CASE-CONVERSION KWD-PRIMAL-PRESERVE)
    (CL:LET*
     ((J NULL-INTEGER) (ITER-003 START) (UPPER-BOUND-003 END)
      (UNBOUNDED?-003 (NULL? UPPER-BOUND-003)))
     (CL:DECLARE (CL:TYPE CL:FIXNUM J ITER-003 UPPER-BOUND-003))
     (CL:LOOP WHILE (CL:OR UNBOUNDED?-003 (CL:<= ITER-003 UPPER-BOUND-003)) DO
      (CL:SETQ J ITER-003)
      (CL:LET
       ((SELF TARGET)
        (CH
         (CL:LET ((SELF SOURCE) (POSITION J))
          (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
           (CL:TYPE CL:FIXNUM POSITION))
          (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
           (CL:THE CL:FIXNUM POSITION))))
        (POSITION TARGET-INDEX))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
        (CL:TYPE CL:FIXNUM POSITION))
       (SETF
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
        (CL:THE CL:CHARACTER CH)))
      (CL:SETQ TARGET-INDEX (CL:1+ TARGET-INDEX))
      (CL:SETQ ITER-003 (CL:1+ ITER-003)))))
   (CL:T
    (CL:LET* ((STREAM-000 (NEW-OUTPUT-STRING-STREAM)))
     (%%PRINT-STREAM (%NATIVE-STREAM STREAM-000) "`" CASE-CONVERSION
      "' is not a valid case option")
     (CL:ERROR (NEW-STELLA-EXCEPTION (THE-STRING-READER STREAM-000))))))
  (CL:RETURN-FROM INSERT-STRING TARGET-INDEX))

;;; (DEFUN (CHARACTER-TO-STRING STRING) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:T) CL:SIMPLE-STRING) CHARACTER-TO-STRING))
(CL:DEFUN CHARACTER-TO-STRING (C)
  "Convert `c' into a one-element string and return the result."
  (CL:RETURN-FROM CHARACTER-TO-STRING (MAKE-STRING 1 C)))

;;; (DEFUN (FORMAT-WITH-PADDING STRING) ...)

(CL:DECLAIM
 (CL:FTYPE
  (CL:FUNCTION (CL:SIMPLE-STRING CL:FIXNUM CL:T CL:T CL:T) CL:SIMPLE-STRING)
  FORMAT-WITH-PADDING))
(CL:DEFUN FORMAT-WITH-PADDING (INPUT LENGTH PADCHAR ALIGN TRUNCATE?)
  "Formats `input' to be (at least) `length' long, using `padchar' to
fill if necessary.  `align' must be one of :LEFT, :RIGHT, :CENTER and will control
how `input' will be justified in the resulting string.  If `truncate?' is true, then
then an overlength string will be truncated, using the opposite of `align' to pick
the truncation direction."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING INPUT) (CL:TYPE CL:FIXNUM LENGTH))
  #+MCL
  (CL:CHECK-TYPE INPUT CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE LENGTH CL:FIXNUM)
  (CL:LET* ((LEN (CL:THE CL:FIXNUM (CL:LENGTH INPUT))))
   (CL:DECLARE (CL:TYPE CL:FIXNUM LEN))
   (CL:COND ((CL:= LEN LENGTH) (CL:RETURN-FROM FORMAT-WITH-PADDING INPUT))
    ((CL:> LEN LENGTH)
     (CL:IF TRUNCATE?
      (CL:COND
       ((CL:EQ ALIGN KWD-PRIMAL-LEFT)
        (CL:RETURN-FROM FORMAT-WITH-PADDING
         (SUBSEQUENCE INPUT (CL:- LEN LENGTH) LEN)))
       ((CL:EQ ALIGN KWD-PRIMAL-RIGHT)
        (CL:RETURN-FROM FORMAT-WITH-PADDING
         (SUBSEQUENCE INPUT 0 (CL:- LEN LENGTH))))
       ((CL:EQ ALIGN KWD-PRIMAL-CENTER)
        (CL:LET* ((LEFT (CL:TRUNCATE (CL:/ (CL:- LEN LENGTH) 2.0d0))))
         (CL:DECLARE (CL:TYPE CL:FIXNUM LEFT))
         (CL:RETURN-FROM FORMAT-WITH-PADDING
          (SUBSEQUENCE INPUT LEFT (CL:+ LEFT LENGTH)))))
       (CL:T
        (CL:LET* ((STREAM-000 (NEW-OUTPUT-STRING-STREAM)))
         (%%PRINT-STREAM (%NATIVE-STREAM STREAM-000) "`" ALIGN
          "' is not a valid case option")
         (CL:ERROR (NEW-STELLA-EXCEPTION (THE-STRING-READER STREAM-000))))))
      (CL:RETURN-FROM FORMAT-WITH-PADDING INPUT)))
    (CL:T
     (CL:COND
      ((CL:EQ ALIGN KWD-PRIMAL-LEFT)
       (CL:RETURN-FROM FORMAT-WITH-PADDING
        (CONCATENATE INPUT (MAKE-STRING (CL:- LENGTH LEN) PADCHAR))))
      ((CL:EQ ALIGN KWD-PRIMAL-RIGHT)
       (CL:RETURN-FROM FORMAT-WITH-PADDING
        (CONCATENATE (MAKE-STRING (CL:- LENGTH LEN) PADCHAR) INPUT)))
      ((CL:EQ ALIGN KWD-PRIMAL-CENTER)
       (CL:LET* ((LEFT (CL:TRUNCATE (CL:/ (CL:- LENGTH LEN) 2.0d0))))
        (CL:DECLARE (CL:TYPE CL:FIXNUM LEFT))
        (CL:RETURN-FROM FORMAT-WITH-PADDING
         (CONCATENATE (MAKE-STRING LEFT PADCHAR) INPUT
          (MAKE-STRING (CL:- LENGTH LEN LEFT) PADCHAR)))))
      (CL:T
       (CL:LET* ((STREAM-001 (NEW-OUTPUT-STRING-STREAM)))
        (%%PRINT-STREAM (%NATIVE-STREAM STREAM-001) "`" ALIGN
         "' is not a valid case option")
        (CL:ERROR (NEW-STELLA-EXCEPTION (THE-STRING-READER STREAM-001))))))))))

;;; (DEFUN (ZERO-PAD-INTEGER STRING) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:SIMPLE-STRING)
  ZERO-PAD-INTEGER))
(CL:DEFUN ZERO-PAD-INTEGER (VALUE SIZE)
  "Returns a string representing `value' of at least length
'size', padded if necessary with 0 characters."
  (CL:DECLARE (CL:TYPE CL:FIXNUM VALUE SIZE))
  #+MCL
  (CL:CHECK-TYPE VALUE CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE SIZE CL:FIXNUM)
  (CL:RETURN-FROM ZERO-PAD-INTEGER (cl:format cl:nil "~v,'0D" size value)))

;;; (DEFUN (ZERO-PAD-STRING STRING) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:SIMPLE-STRING CL:FIXNUM) CL:SIMPLE-STRING)
  ZERO-PAD-STRING))
(CL:DEFUN ZERO-PAD-STRING (INPUT SIZE)
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING INPUT) (CL:TYPE CL:FIXNUM SIZE))
  #+MCL
  (CL:CHECK-TYPE INPUT CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE SIZE CL:FIXNUM)
  (CL:RETURN-FROM ZERO-PAD-STRING
   (FORMAT-WITH-PADDING INPUT SIZE #\0 KWD-PRIMAL-RIGHT CL:NIL)))

;;; (DEFMETHOD (FIRST CHARACTER) ...)

(CL:DEFMETHOD FIRST ((SELF CL:STRING))
  "Return the first character of `self'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM FIRST
   (CL:LET ((SELF SELF) (POSITION 0))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFMETHOD (FIRST CHARACTER) ...)

(CL:DEFMETHOD FIRST ((SELF CL:STRING))
  "Return the first character of `self' (settable via `setf')."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM FIRST
   (CL:LET ((SELF SELF) (POSITION 0))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFMETHOD (FIRST-SETTER CHARACTER) ...)

(CL:DEFMETHOD FIRST-SETTER ((SELF CL:STRING) CH)
  "Set the first character of `self' to `ch' and return `ch'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM FIRST-SETTER
   (CL:LET ((SELF SELF) (CH CH) (POSITION 0))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (SETF
     (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
     (CL:THE CL:CHARACTER CH)))))

;;; (DEFMETHOD (SECOND CHARACTER) ...)

(CL:DEFMETHOD SECOND ((SELF CL:STRING))
  "Return the second character of `self'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM SECOND
   (CL:LET ((SELF SELF) (POSITION 1))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFMETHOD (SECOND CHARACTER) ...)

(CL:DEFMETHOD SECOND ((SELF CL:STRING))
  "Return the second character of `self' (settable via `setf')."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM SECOND
   (CL:LET ((SELF SELF) (POSITION 1))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFMETHOD (SECOND-SETTER CHARACTER) ...)

(CL:DEFMETHOD SECOND-SETTER ((SELF CL:STRING) CH)
  "Set the second character of `self' to `ch' and return `ch'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM SECOND-SETTER
   (CL:LET ((SELF SELF) (CH CH) (POSITION 1))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (SETF
     (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
     (CL:THE CL:CHARACTER CH)))))

;;; (DEFMETHOD (THIRD CHARACTER) ...)

(CL:DEFMETHOD THIRD ((SELF CL:STRING))
  "Return the third character of `self'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM THIRD
   (CL:LET ((SELF SELF) (POSITION 2))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFMETHOD (THIRD CHARACTER) ...)

(CL:DEFMETHOD THIRD ((SELF CL:STRING))
  "Return the third character of `self' (settable via `setf')."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM THIRD
   (CL:LET ((SELF SELF) (POSITION 2))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFMETHOD (THIRD-SETTER CHARACTER) ...)

(CL:DEFMETHOD THIRD-SETTER ((SELF CL:STRING) CH)
  "Set the third character of `self' to `ch' and return `ch'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM THIRD-SETTER
   (CL:LET ((SELF SELF) (CH CH) (POSITION 2))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (SETF
     (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
     (CL:THE CL:CHARACTER CH)))))

;;; (DEFMETHOD (FOURTH CHARACTER) ...)

(CL:DEFMETHOD FOURTH ((SELF CL:STRING))
  "Return the fourth character of `self'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM FOURTH
   (CL:LET ((SELF SELF) (POSITION 3))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFMETHOD (FOURTH CHARACTER) ...)

(CL:DEFMETHOD FOURTH ((SELF CL:STRING))
  "Return the fourth character of `self' (settable via `setf')."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM FOURTH
   (CL:LET ((SELF SELF) (POSITION 3))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFMETHOD (FOURTH-SETTER CHARACTER) ...)

(CL:DEFMETHOD FOURTH-SETTER ((SELF CL:STRING) CH)
  "Set the fourth character of `self' to `ch' and return `ch'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM FOURTH-SETTER
   (CL:LET ((SELF SELF) (CH CH) (POSITION 3))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (SETF
     (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
     (CL:THE CL:CHARACTER CH)))))

;;; (DEFMETHOD (FIFTH CHARACTER) ...)

(CL:DEFMETHOD FIFTH ((SELF CL:STRING))
  "Return the fifth character of `self'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM FIFTH
   (CL:LET ((SELF SELF) (POSITION 4))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFMETHOD (FIFTH CHARACTER) ...)

(CL:DEFMETHOD FIFTH ((SELF CL:STRING))
  "Return the fifth character of `self' (settable via `setf')."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM FIFTH
   (CL:LET ((SELF SELF) (POSITION 4))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))

;;; (DEFMETHOD (FIFTH-SETTER CHARACTER) ...)

(CL:DEFMETHOD FIFTH-SETTER ((SELF CL:STRING) CH)
  "Set the fifth character of `self' to `ch' and return `ch'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM FIFTH-SETTER
   (CL:LET ((SELF SELF) (CH CH) (POSITION 4))
    (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
    (SETF
     (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
     (CL:THE CL:CHARACTER CH)))))

;;; (DEFMETHOD (NTH CHARACTER) ...)

(CL:DEFMETHOD NTH ((SELF CL:STRING) POSITION)
  "Return the character in `self' at `position'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE POSITION CL:FIXNUM)
  (CL:RETURN-FROM NTH
   (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))))

;;; (DEFMETHOD (NTH CHARACTER) ...)

(CL:DEFMETHOD NTH ((SELF CL:STRING) POSITION)
  "Return the character in `self' at `position'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE POSITION CL:FIXNUM)
  (CL:RETURN-FROM NTH
   (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))))

;;; (DEFMETHOD (NTH-SETTER CHARACTER) ...)

(CL:DEFMETHOD NTH-SETTER ((SELF CL:STRING) CH POSITION)
  "Set the character in `self' at `position' to `ch'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF) (CL:TYPE CL:FIXNUM POSITION))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE POSITION CL:FIXNUM)
  (CL:RETURN-FROM NTH-SETTER
   (SETF (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION))
    (CL:THE CL:CHARACTER CH))))

;;; (DEFMETHOD (LENGTH INTEGER) ...)

(CL:DEFMETHOD LENGTH ((SELF CL:STRING))
  "Return the length of the string `self'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM LENGTH (CL:LENGTH SELF)))

;;; (DEFMETHOD (LENGTH INTEGER) ...)

(CL:DEFMETHOD LENGTH ((SELF CL:STRING))
  "Return the length of the string `self'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM LENGTH (CL:LENGTH SELF)))

;;; (DEFUN (STARTS-WITH? BOOLEAN) ...)

(CL:DEFUN STARTS-WITH? (STRING PREFIX START)
  "Return TRUE if `string' starts with `prefix' starting from
`start' (which defaults to 0 if it is supplied as NULL)."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING STRING PREFIX)
   (CL:TYPE CL:FIXNUM START))
  #+MCL
  (CL:CHECK-TYPE STRING CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE PREFIX CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START CL:FIXNUM)
  (CL:WHEN (NULL? START) (CL:SETQ START 0))
  (CL:LET* ((PREFIXLENGTH (CL:THE CL:FIXNUM (CL:LENGTH PREFIX))))
   (CL:DECLARE (CL:TYPE CL:FIXNUM PREFIXLENGTH))
   (CL:IF
    (CL:> (CL:+ START PREFIXLENGTH) (CL:THE CL:FIXNUM (CL:LENGTH STRING)))
    (CL:RETURN-FROM STARTS-WITH? CL:NIL)
    (CL:LET* ((ALWAYS?-000 CL:T))
     (CL:LET*
      ((I NULL-INTEGER) (ITER-000 0) (UPPER-BOUND-000 (CL:1- PREFIXLENGTH))
       (J NULL-INTEGER) (ITER-001 START))
      (CL:DECLARE (CL:TYPE CL:FIXNUM I ITER-000 UPPER-BOUND-000 J ITER-001))
      (CL:LOOP WHILE (CL:<= ITER-000 UPPER-BOUND-000) DO (CL:SETQ I ITER-000)
       (CL:SETQ J ITER-001)
       (CL:WHEN
        (CL:NOT
         (CL:EQL
          (CL:LET ((SELF PREFIX) (POSITION I))
           (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
            (CL:TYPE CL:FIXNUM POSITION))
           (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
            (CL:THE CL:FIXNUM POSITION)))
          (CL:LET ((SELF STRING) (POSITION J))
           (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
            (CL:TYPE CL:FIXNUM POSITION))
           (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
            (CL:THE CL:FIXNUM POSITION)))))
        (CL:SETQ ALWAYS?-000 CL:NIL) (CL:RETURN))
       (CL:SETQ ITER-000 (CL:1+ ITER-000))
       (CL:SETQ ITER-001 (CL:1+ ITER-001))))
     (CL:LET* ((VALUE-000 ALWAYS?-000))
      (CL:RETURN-FROM STARTS-WITH? VALUE-000))))))

;;; (DEFUN (HELP-FIND-MATCHING-PREFIX-LENGTH INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE
  (CL:FUNCTION
   (CL:SIMPLE-STRING CL:FIXNUM CL:FIXNUM CL:SIMPLE-STRING CL:FIXNUM CL:FIXNUM)
   CL:FIXNUM)
  HELP-FIND-MATCHING-PREFIX-LENGTH))
(CL:DEFUN HELP-FIND-MATCHING-PREFIX-LENGTH (STRING1 START1 END1 STRING2 START2 END2)
  "Helping function for `find-matching-prefix' that requires `end1' and `end2'
to be properly set up."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING STRING1 STRING2)
   (CL:TYPE CL:FIXNUM START1 END1 START2 END2))
  #+MCL
  (CL:CHECK-TYPE STRING1 CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START1 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE END1 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE STRING2 CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START2 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE END2 CL:FIXNUM)
  (CL:LET* ((I1 START1) (I2 START2)) (CL:DECLARE (CL:TYPE CL:FIXNUM I1 I2))
   (CL:LOOP WHILE
    (CL:AND (CL:< I1 END1) (CL:< I2 END2)
     (CL:EQL
      (CL:LET ((SELF STRING1) (POSITION I1))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
        (CL:TYPE CL:FIXNUM POSITION))
       (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))
      (CL:LET ((SELF STRING2) (POSITION I2))
       (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
        (CL:TYPE CL:FIXNUM POSITION))
       (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
        (CL:THE CL:FIXNUM POSITION)))))
    DO (CL:SETQ I1 (CL:1+ I1)) (CL:SETQ I2 (CL:1+ I2)))
   (CL:RETURN-FROM HELP-FIND-MATCHING-PREFIX-LENGTH (CL:- I1 START1))))

;;; (DEFUN (FIND-MATCHING-PREFIX-LENGTH INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE
  (CL:FUNCTION
   (CL:SIMPLE-STRING CL:FIXNUM CL:FIXNUM CL:SIMPLE-STRING CL:FIXNUM CL:FIXNUM)
   CL:FIXNUM)
  FIND-MATCHING-PREFIX-LENGTH))
(CL:DEFUN FIND-MATCHING-PREFIX-LENGTH (STRING1 START1 END1 STRING2 START2 END2)
  "Finds the length of the matching prefix strings of `string1' and
`string2', starting at position `start1' and `start2' respectively.
The search will end when `end1' or `end2' is reached.  If either `end1'
or `end2' is null, then they will be set to the length of their respective
strings."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING STRING1 STRING2)
   (CL:TYPE CL:FIXNUM START1 END1 START2 END2))
  #+MCL
  (CL:CHECK-TYPE STRING1 CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START1 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE END1 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE STRING2 CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START2 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE END2 CL:FIXNUM)
  (CL:WHEN (NULL? END1) (CL:SETQ END1 (CL:THE CL:FIXNUM (CL:LENGTH STRING1))))
  (CL:WHEN (NULL? END2) (CL:SETQ END2 (CL:THE CL:FIXNUM (CL:LENGTH STRING2))))
  (CL:RETURN-FROM FIND-MATCHING-PREFIX-LENGTH
   (HELP-FIND-MATCHING-PREFIX-LENGTH STRING1 START1 END1 STRING2 START2 END2)))

;;; (DEFUN (FIND-MISMATCH INTEGER INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE
  (CL:FUNCTION
   (CL:SIMPLE-STRING CL:FIXNUM CL:FIXNUM CL:SIMPLE-STRING CL:FIXNUM CL:FIXNUM)
   (CL:VALUES CL:FIXNUM CL:FIXNUM))
  FIND-MISMATCH))
(CL:DEFUN FIND-MISMATCH (STRING1 START1 END1 STRING2 START2 END2)
  "Finds the first position in each of `string1' and `string2' where
they mismatch, starting at position `start1' and `start2' respectively.
The search will end when `end1' or `end2' is reached.  If either `end1'
or `end2' is null, then they will be set to the length of their respective
strings.  If there is no mismatch, then `null' values are returned."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING STRING1 STRING2)
   (CL:TYPE CL:FIXNUM START1 END1 START2 END2))
  #+MCL
  (CL:CHECK-TYPE STRING1 CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START1 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE END1 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE STRING2 CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START2 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE END2 CL:FIXNUM)
  (CL:WHEN (NULL? END1) (CL:SETQ END1 (CL:THE CL:FIXNUM (CL:LENGTH STRING1))))
  (CL:WHEN (NULL? END2) (CL:SETQ END2 (CL:THE CL:FIXNUM (CL:LENGTH STRING2))))
  (CL:LET*
   ((LEN
     (HELP-FIND-MATCHING-PREFIX-LENGTH STRING1 START1 END1 STRING2 START2
      END2)))
   (CL:DECLARE (CL:TYPE CL:FIXNUM LEN)) (CL:SETQ START1 (CL:+ START1 LEN))
   (CL:SETQ START2 (CL:+ START2 LEN))
   (CL:IF (CL:AND (CL:= START1 END1) (CL:= START2 END2))
    (CL:RETURN-FROM FIND-MISMATCH (CL:VALUES NULL-INTEGER NULL-INTEGER))
    (CL:RETURN-FROM FIND-MISMATCH (CL:VALUES START1 START2)))))

;;; (DEFUN (NON-MATCHING-POSITION-HELPER INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE
  (CL:FUNCTION (CL:SIMPLE-STRING CL:FIXNUM CL:FIXNUM CL:SIMPLE-STRING)
   CL:FIXNUM)
  NON-MATCHING-POSITION-HELPER))
(CL:DEFUN NON-MATCHING-POSITION-HELPER (SOURCE START END MATCH)
  "Helper for `non-matching-position' that requires `end' to not be `null'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SOURCE MATCH)
   (CL:TYPE CL:FIXNUM START END))
  #+MCL
  (CL:CHECK-TYPE SOURCE CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE END CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE MATCH CL:SIMPLE-STRING)
  (CL:LOOP WHILE
   (CL:AND (CL:< START END)
    (MEMBER? MATCH
     (CL:LET ((SELF SOURCE) (POSITION START))
      (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
       (CL:TYPE CL:FIXNUM POSITION))
      (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))))
   DO (CL:SETQ START (CL:1+ START)))
  (CL:RETURN-FROM NON-MATCHING-POSITION-HELPER START))

;;; (DEFUN (NON-MATCHING-POSITION INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE
  (CL:FUNCTION (CL:SIMPLE-STRING CL:FIXNUM CL:SIMPLE-STRING) CL:FIXNUM)
  NON-MATCHING-POSITION))
(CL:DEFUN NON-MATCHING-POSITION (SOURCE START MATCH)
  "Returns the index into `source', starting from `start', of the first
character that is not included in `match'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SOURCE MATCH)
   (CL:TYPE CL:FIXNUM START))
  #+MCL
  (CL:CHECK-TYPE SOURCE CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE MATCH CL:SIMPLE-STRING)
  (CL:RETURN-FROM NON-MATCHING-POSITION
   (NON-MATCHING-POSITION-HELPER SOURCE START
    (CL:THE CL:FIXNUM (CL:LENGTH SOURCE)) MATCH)))

;;; (DEFUN (HELP-ADVANCE-PAST-WHITESPACE INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:SIMPLE-STRING CL:FIXNUM CL:FIXNUM) CL:FIXNUM)
  HELP-ADVANCE-PAST-WHITESPACE))
(CL:DEFUN HELP-ADVANCE-PAST-WHITESPACE (SOURCE START END)
  "Helper for `advance-past-whitespace' that requires `end' to be properly set."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SOURCE) (CL:TYPE CL:FIXNUM START END))
  #+MCL
  (CL:CHECK-TYPE SOURCE CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE END CL:FIXNUM)
  (CL:LOOP WHILE
   (CL:AND (CL:< START END)
    (CL:EQ
     (CL:AREF *CHARACTER-TYPE-TABLE*
      (CL:THE CL:FIXNUM
       (CL:CHAR-CODE
        (CL:LET ((SELF SOURCE) (POSITION START))
         (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
          (CL:TYPE CL:FIXNUM POSITION))
         (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
          (CL:THE CL:FIXNUM POSITION))))))
     KWD-PRIMAL-WHITE-SPACE))
   DO (CL:SETQ START (CL:1+ START)))
  (CL:RETURN-FROM HELP-ADVANCE-PAST-WHITESPACE START))

;;; (DEFUN (ADVANCE-PAST-WHITESPACE INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:SIMPLE-STRING CL:FIXNUM) CL:FIXNUM)
  ADVANCE-PAST-WHITESPACE))
(CL:DEFUN ADVANCE-PAST-WHITESPACE (SOURCE START)
  "Returns the first index into `source', starting from `start', of
the first character that is not white space."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SOURCE) (CL:TYPE CL:FIXNUM START))
  #+MCL
  (CL:CHECK-TYPE SOURCE CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE START CL:FIXNUM)
  (CL:RETURN-FROM ADVANCE-PAST-WHITESPACE
   (HELP-ADVANCE-PAST-WHITESPACE SOURCE START
    (CL:THE CL:FIXNUM (CL:LENGTH SOURCE)))))

;;; (DEFUN (EQL-EXCEPT-IN-WHITESPACE? BOOLEAN) ...)

(CL:DEFUN EQL-EXCEPT-IN-WHITESPACE? (S1 S2)
  "Return `true' if the strings `s1' and `s2' are the same
except for the amounts of whitespace separating words.  Leading or
trailing whitespace is also not considered."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING S1 S2))
  #+MCL
  (CL:CHECK-TYPE S1 CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE S2 CL:SIMPLE-STRING)
  (CL:COND
   ((CL:EQ S1 STELLA::NULL-STRING)
    (CL:RETURN-FROM EQL-EXCEPT-IN-WHITESPACE? (CL:EQ S2 STELLA::NULL-STRING)))
   ((CL:EQ S2 STELLA::NULL-STRING)
    (CL:RETURN-FROM EQL-EXCEPT-IN-WHITESPACE? CL:NIL))
   ((STRING-EQL? S1 S2) (CL:RETURN-FROM EQL-EXCEPT-IN-WHITESPACE? CL:T)))
  (CL:LET*
   ((LEN1 (CL:THE CL:FIXNUM (CL:LENGTH S1)))
    (LEN2 (CL:THE CL:FIXNUM (CL:LENGTH S2))) (I1 0) (I2 0))
   (CL:DECLARE (CL:TYPE CL:FIXNUM LEN1 LEN2 I1 I2))
   (CL:LOOP WHILE (CL:AND (CL:< I1 LEN1) (CL:< I2 LEN2)) DO
    (CL:COND
     ((CL:EQ
       (CL:AREF *CHARACTER-TYPE-TABLE*
        (CL:THE CL:FIXNUM
         (CL:CHAR-CODE
          (CL:LET ((SELF S1) (POSITION I1))
           (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
            (CL:TYPE CL:FIXNUM POSITION))
           (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
            (CL:THE CL:FIXNUM POSITION))))))
       KWD-PRIMAL-WHITE-SPACE)
      (CL:IF
       (CL:EQ
        (CL:AREF *CHARACTER-TYPE-TABLE*
         (CL:THE CL:FIXNUM
          (CL:CHAR-CODE
           (CL:LET ((SELF S2) (POSITION I2))
            (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
             (CL:TYPE CL:FIXNUM POSITION))
            (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
             (CL:THE CL:FIXNUM POSITION))))))
        KWD-PRIMAL-WHITE-SPACE)
       (CL:PROGN
        (CL:LOOP WHILE
         (CL:AND (CL:< I1 LEN1)
          (CL:EQ
           (CL:AREF *CHARACTER-TYPE-TABLE*
            (CL:THE CL:FIXNUM
             (CL:CHAR-CODE
              (CL:LET ((SELF S1) (POSITION I1))
               (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
                (CL:TYPE CL:FIXNUM POSITION))
               (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
                (CL:THE CL:FIXNUM POSITION))))))
           KWD-PRIMAL-WHITE-SPACE))
         DO (CL:SETQ I1 (CL:1+ I1)))
        (CL:LOOP WHILE
         (CL:AND (CL:< I2 LEN2)
          (CL:EQ
           (CL:AREF *CHARACTER-TYPE-TABLE*
            (CL:THE CL:FIXNUM
             (CL:CHAR-CODE
              (CL:LET ((SELF S2) (POSITION I2))
               (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
                (CL:TYPE CL:FIXNUM POSITION))
               (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
                (CL:THE CL:FIXNUM POSITION))))))
           KWD-PRIMAL-WHITE-SPACE))
         DO (CL:SETQ I2 (CL:1+ I2))))
       (CL:RETURN-FROM EQL-EXCEPT-IN-WHITESPACE? CL:NIL)))
     ((CL:EQL
       (CL:LET ((SELF S1) (POSITION I1))
        (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
         (CL:TYPE CL:FIXNUM POSITION))
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)))
       (CL:LET ((SELF S2) (POSITION I2))
        (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
         (CL:TYPE CL:FIXNUM POSITION))
        (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
         (CL:THE CL:FIXNUM POSITION))))
      (CL:SETQ I1 (CL:1+ I1)) (CL:SETQ I2 (CL:1+ I2)))
     (CL:T (CL:RETURN-FROM EQL-EXCEPT-IN-WHITESPACE? CL:NIL))))
   (CL:LOOP WHILE
    (CL:AND (CL:< I1 LEN1)
     (CL:EQ
      (CL:AREF *CHARACTER-TYPE-TABLE*
       (CL:THE CL:FIXNUM
        (CL:CHAR-CODE
         (CL:LET ((SELF S1) (POSITION I1))
          (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
           (CL:TYPE CL:FIXNUM POSITION))
          (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
           (CL:THE CL:FIXNUM POSITION))))))
      KWD-PRIMAL-WHITE-SPACE))
    DO (CL:SETQ I1 (CL:1+ I1)))
   (CL:LOOP WHILE
    (CL:AND (CL:< I2 LEN2)
     (CL:EQ
      (CL:AREF *CHARACTER-TYPE-TABLE*
       (CL:THE CL:FIXNUM
        (CL:CHAR-CODE
         (CL:LET ((SELF S2) (POSITION I2))
          (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
           (CL:TYPE CL:FIXNUM POSITION))
          (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
           (CL:THE CL:FIXNUM POSITION))))))
      KWD-PRIMAL-WHITE-SPACE))
    DO (CL:SETQ I2 (CL:1+ I2)))
   (CL:RETURN-FROM EQL-EXCEPT-IN-WHITESPACE?
    (CL:AND (CL:= I1 LEN1) (CL:= I2 LEN2)))))

;;; (DEFUN (UNSTRINGIFY OBJECT) ...)

(CL:DEFUN UNSTRINGIFY (STRING)
  "Read a STELLA expression from `string' and return the result.
This is identical to `read-s-expression-from-string'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING STRING))
  #+MCL
  (CL:CHECK-TYPE STRING CL:SIMPLE-STRING)
  (CL:RETURN-FROM UNSTRINGIFY (READ-S-EXPRESSION-FROM-STRING STRING)))

;;; (DEFMETHOD FREE-HASH-TABLE-VALUES ...)

(CL:DEFMETHOD FREE-HASH-TABLE-VALUES ((SELF ABSTRACT-HASH-TABLE))
  "Call free on each value in the hash table `self'."
  (CL:WHEN *USE-STELLA-HASH-TABLES?* (CL:RETURN-FROM FREE-HASH-TABLE-VALUES))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:maphash #'(CL:lambda (key value)
				     (CL:declare (CL:ignore key))
				     (free value))
				 native-table))
  :VOID)

;;; (DEFMETHOD INITIALIZE-HASH-TABLE ...)

(CL:DEFMETHOD INITIALIZE-HASH-TABLE ((SELF ABSTRACT-HASH-TABLE))
  "Insert a newly-created native hash table into `self'."
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (CL:SETF (%THE-STELLA-HASH-TABLE SELF) (NEW-STELLA-HASH-TABLE))
   (CL:RETURN-FROM INITIALIZE-HASH-TABLE))
  (CL:SETF (%THE-HASH-TABLE SELF) (CL:make-hash-table :test #'CL:eql))
  :VOID)

;;; (DEFMETHOD (LOOKUP (LIKE (ANY-VALUE SELF))) ...)

(CL:DEFMETHOD LOOKUP ((SELF HASH-TABLE) KEY)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (CL:RETURN-FROM LOOKUP
    (STELLA-HASH-TABLE-LOOKUP (%THE-STELLA-HASH-TABLE SELF) KEY)))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:RETURN-FROM LOOKUP (CL:OR (CL:GETHASH KEY NATIVE-TABLE) NULL))))

;;; (DEFMETHOD INSERT-AT ...)

(CL:DEFMETHOD INSERT-AT ((SELF HASH-TABLE) KEY VALUE)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (STELLA-HASH-TABLE-INSERT-AT (%THE-STELLA-HASH-TABLE SELF) KEY VALUE)
   (CL:RETURN-FROM INSERT-AT))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:SETF (CL:GETHASH KEY NATIVE-TABLE) VALUE))
  :VOID)

;;; (DEFMETHOD REMOVE-AT ...)

(CL:DEFMETHOD REMOVE-AT ((SELF HASH-TABLE) KEY)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (STELLA-HASH-TABLE-REMOVE-AT (%THE-STELLA-HASH-TABLE SELF) KEY)
   (CL:RETURN-FROM REMOVE-AT))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:REMHASH KEY NATIVE-TABLE))
  :VOID)

;;; (DEFMETHOD INITIALIZE-HASH-TABLE ...)

(CL:DEFMETHOD INITIALIZE-HASH-TABLE ((SELF INTEGER-HASH-TABLE))
  "Insert a newly-created native hash table into `self'."
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (CL:SETF (%THE-STELLA-HASH-TABLE SELF) (NEW-STELLA-HASH-TABLE))
   (CL:RETURN-FROM INITIALIZE-HASH-TABLE))
  (CL:SETF (%THE-HASH-TABLE SELF) (CL:make-hash-table :test #'CL:eql))
  :VOID)

;;; (DEFMETHOD (LOOKUP (LIKE (ANY-VALUE SELF))) ...)

(CL:DEFMETHOD LOOKUP ((SELF INTEGER-HASH-TABLE) KEY)
  (CL:DECLARE (CL:TYPE CL:FIXNUM KEY))
  #+MCL
  (CL:CHECK-TYPE KEY CL:FIXNUM)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (CL:RETURN-FROM LOOKUP
    (STELLA-HASH-TABLE-LOOKUP (%THE-STELLA-HASH-TABLE SELF)
     (WRAP-INTEGER KEY))))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:RETURN-FROM LOOKUP (CL:OR (CL:GETHASH KEY NATIVE-TABLE) NULL))))

;;; (DEFMETHOD INSERT-AT ...)

(CL:DEFMETHOD INSERT-AT ((SELF INTEGER-HASH-TABLE) KEY VALUE)
  (CL:DECLARE (CL:TYPE CL:FIXNUM KEY))
  #+MCL
  (CL:CHECK-TYPE KEY CL:FIXNUM)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (STELLA-HASH-TABLE-INSERT-AT (%THE-STELLA-HASH-TABLE SELF)
    (WRAP-INTEGER KEY) VALUE)
   (CL:RETURN-FROM INSERT-AT))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:DECLARE (CL:FIXNUM KEY)) (CL:SETF (CL:GETHASH KEY NATIVE-TABLE) VALUE))
  :VOID)

;;; (DEFMETHOD REMOVE-AT ...)

(CL:DEFMETHOD REMOVE-AT ((SELF INTEGER-HASH-TABLE) KEY)
  (CL:DECLARE (CL:TYPE CL:FIXNUM KEY))
  #+MCL
  (CL:CHECK-TYPE KEY CL:FIXNUM)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (STELLA-HASH-TABLE-REMOVE-AT (%THE-STELLA-HASH-TABLE SELF)
    (WRAP-INTEGER KEY))
   (CL:RETURN-FROM REMOVE-AT))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:REMHASH KEY NATIVE-TABLE))
  :VOID)

;;; (DEFMETHOD INITIALIZE-HASH-TABLE ...)

(CL:DEFMETHOD INITIALIZE-HASH-TABLE ((SELF FLOAT-HASH-TABLE))
  "Insert a newly-created native hash table into `self'."
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (CL:SETF (%THE-STELLA-HASH-TABLE SELF) (NEW-STELLA-HASH-TABLE))
   (CL:RETURN-FROM INITIALIZE-HASH-TABLE))
  (CL:SETF (%THE-HASH-TABLE SELF) (CL:make-hash-table :test #'CL:eql))
  :VOID)

;;; (DEFMETHOD (LOOKUP (LIKE (ANY-VALUE SELF))) ...)

(CL:DEFMETHOD LOOKUP ((SELF FLOAT-HASH-TABLE) KEY)
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT KEY))
  #+MCL
  (CL:CHECK-TYPE KEY CL:DOUBLE-FLOAT)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (CL:RETURN-FROM LOOKUP
    (STELLA-HASH-TABLE-LOOKUP (%THE-STELLA-HASH-TABLE SELF) (WRAP-FLOAT KEY))))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:RETURN-FROM LOOKUP (CL:OR (CL:GETHASH KEY NATIVE-TABLE) NULL))))

;;; (DEFMETHOD INSERT-AT ...)

(CL:DEFMETHOD INSERT-AT ((SELF FLOAT-HASH-TABLE) KEY VALUE)
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT KEY))
  #+MCL
  (CL:CHECK-TYPE KEY CL:DOUBLE-FLOAT)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (STELLA-HASH-TABLE-INSERT-AT (%THE-STELLA-HASH-TABLE SELF) (WRAP-FLOAT KEY)
    VALUE)
   (CL:RETURN-FROM INSERT-AT))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:SETF (CL:GETHASH KEY NATIVE-TABLE) VALUE))
  :VOID)

;;; (DEFMETHOD REMOVE-AT ...)

(CL:DEFMETHOD REMOVE-AT ((SELF FLOAT-HASH-TABLE) KEY)
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT KEY))
  #+MCL
  (CL:CHECK-TYPE KEY CL:DOUBLE-FLOAT)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (STELLA-HASH-TABLE-REMOVE-AT (%THE-STELLA-HASH-TABLE SELF)
    (WRAP-FLOAT KEY))
   (CL:RETURN-FROM REMOVE-AT))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:REMHASH KEY NATIVE-TABLE))
  :VOID)

;;; (DEFMETHOD INITIALIZE-HASH-TABLE ...)

(CL:DEFMETHOD INITIALIZE-HASH-TABLE ((SELF STRING-HASH-TABLE))
  "Insert a newly-created native hash table into `self'."
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (CL:SETF (%THE-STELLA-HASH-TABLE SELF) (NEW-STELLA-HASH-TABLE))
   (CL:RETURN-FROM INITIALIZE-HASH-TABLE))
  (CL:SETF (%THE-HASH-TABLE SELF) (CL:make-hash-table :test #'CL:equal))
  :VOID)

;;; (DEFMETHOD (LOOKUP (LIKE (ANY-VALUE SELF))) ...)

(CL:DEFMETHOD LOOKUP ((SELF STRING-HASH-TABLE) KEY)
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING KEY))
  #+MCL
  (CL:CHECK-TYPE KEY CL:SIMPLE-STRING)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (CL:RETURN-FROM LOOKUP
    (STELLA-STRING-HASH-TABLE-LOOKUP (%THE-STELLA-HASH-TABLE SELF) KEY)))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:RETURN-FROM LOOKUP (CL:OR (CL:GETHASH KEY NATIVE-TABLE) NULL))))

;;; (DEFMETHOD INSERT-AT ...)

(CL:DEFMETHOD INSERT-AT ((SELF STRING-HASH-TABLE) KEY VALUE)
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING KEY))
  #+MCL
  (CL:CHECK-TYPE KEY CL:SIMPLE-STRING)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (STELLA-HASH-TABLE-INSERT-AT (%THE-STELLA-HASH-TABLE SELF)
    (WRAP-STRING KEY) VALUE)
   (CL:RETURN-FROM INSERT-AT))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:SETF (CL:GETHASH KEY NATIVE-TABLE) VALUE))
  :VOID)

;;; (DEFMETHOD REMOVE-AT ...)

(CL:DEFMETHOD REMOVE-AT ((SELF STRING-HASH-TABLE) KEY)
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING KEY))
  #+MCL
  (CL:CHECK-TYPE KEY CL:SIMPLE-STRING)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (STELLA-HASH-TABLE-REMOVE-AT (%THE-STELLA-HASH-TABLE SELF)
    (WRAP-STRING KEY))
   (CL:RETURN-FROM REMOVE-AT))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:REMHASH KEY NATIVE-TABLE))
  :VOID)

;;; (DEFMETHOD INITIALIZE-HASH-TABLE ...)

(CL:DEFMETHOD INITIALIZE-HASH-TABLE ((SELF STRING-TO-INTEGER-HASH-TABLE))
  "Insert a newly-created native hash table into `self'."
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (CL:SETF (%THE-STELLA-HASH-TABLE SELF) (NEW-STELLA-HASH-TABLE))
   (CL:RETURN-FROM INITIALIZE-HASH-TABLE))
  (CL:SETF (%THE-HASH-TABLE SELF) (CL:make-hash-table :test #'CL:equal))
  :VOID)

;;; (DEFMETHOD (LOOKUP INTEGER) ...)

(CL:DEFMETHOD LOOKUP ((SELF STRING-TO-INTEGER-HASH-TABLE) KEY)
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING KEY))
  #+MCL
  (CL:CHECK-TYPE KEY CL:SIMPLE-STRING)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (CL:RETURN-FROM LOOKUP
    (UNWRAP-INTEGER
     (STELLA-STRING-HASH-TABLE-LOOKUP (%THE-STELLA-HASH-TABLE SELF) KEY))))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)) (RESULT NULL-INTEGER))
   (CL:DECLARE (CL:TYPE CL:FIXNUM RESULT))
   (CL:SETQ RESULT (CL:OR (CL:GETHASH KEY NATIVE-TABLE) NULL-INTEGER))
   (CL:RETURN-FROM LOOKUP RESULT)))

;;; (DEFMETHOD INSERT-AT ...)

(CL:DEFMETHOD INSERT-AT ((SELF STRING-TO-INTEGER-HASH-TABLE) KEY VALUE)
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING KEY) (CL:TYPE CL:FIXNUM VALUE))
  #+MCL
  (CL:CHECK-TYPE KEY CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE VALUE CL:FIXNUM)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (STELLA-HASH-TABLE-INSERT-AT (%THE-STELLA-HASH-TABLE SELF)
    (WRAP-STRING KEY) (WRAP-INTEGER VALUE))
   (CL:RETURN-FROM INSERT-AT))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:SETF (CL:GETHASH KEY NATIVE-TABLE) VALUE))
  :VOID)

;;; (DEFMETHOD REMOVE-AT ...)

(CL:DEFMETHOD REMOVE-AT ((SELF STRING-TO-INTEGER-HASH-TABLE) KEY)
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING KEY))
  #+MCL
  (CL:CHECK-TYPE KEY CL:SIMPLE-STRING)
  (CL:WHEN *USE-STELLA-HASH-TABLES?*
   (STELLA-HASH-TABLE-REMOVE-AT (%THE-STELLA-HASH-TABLE SELF)
    (WRAP-STRING KEY))
   (CL:RETURN-FROM REMOVE-AT))
  (CL:LET* ((NATIVE-TABLE (%THE-HASH-TABLE SELF)))
   (CL:REMHASH KEY NATIVE-TABLE))
  :VOID)

;;; (DEFGLOBAL *HASH-BYTE-RANDOM-TABLE* ...)

(CL:DEFVAR *HASH-BYTE-RANDOM-TABLE* NULL
  "A table of 256 N-bit random numbers that can be used to
hash sequences of bytes.  Each bit-column in the table has an approximately
even number of 0's and 1's.")
(CL:DECLAIM (CL:TYPE CL:SIMPLE-VECTOR *HASH-BYTE-RANDOM-TABLE*))

;;; (DEFCONSTANT *INTEGER-MSB-MASK* ...)

(CL:DEFVAR *INTEGER-MSB-MASK* #.(CL:ash 1 (CL:1- (CL:integer-length CL:most-positive-fixnum)))
  "The most significant bit of a regular integer (FIXNUM
in Common-Lisp).  In C++ and Java this corresponds to the sign bit, in
Lisp this corresponds to the left-most bit of `CL:most-positive-fixnum'.")
(CL:DECLAIM (CL:TYPE CL:FIXNUM *INTEGER-MSB-MASK*))

;;; (DEFCONSTANT *INTEGER-UNSIGNED-BITS-MASK* ...)

(CL:DEFVAR *INTEGER-UNSIGNED-BITS-MASK* (CL:LOGIOR (CL:1- *INTEGER-MSB-MASK*) *INTEGER-MSB-MASK*)
  "Mask that covers all the unsigned bits of an integer.")
(CL:DECLAIM (CL:TYPE CL:FIXNUM *INTEGER-UNSIGNED-BITS-MASK*))

;;; (DEFUN (HASHMOD INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) HASHMOD))
(CL:DEFUN HASHMOD (CODE SIZE)
  "Map the hash code `code' onto a bucket index for a hash table
of `size' (i.e., onto the interval [0..size-1].  This is just like `rem' for
positive hash codes but also works for negative hash codes by mapping those
onto a positive number first.  Note, that the sign conversion mapping is not
equivalent to calling the `abs' function (it simply masks the sign bit for
speed) and therefore really only makes sense for hash codes."
  (CL:DECLARE (CL:TYPE CL:FIXNUM CODE SIZE))
  #+MCL
  (CL:CHECK-TYPE CODE CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE SIZE CL:FIXNUM)
  (CL:RETURN-FROM HASHMOD
   (CL:REM (CL:THE CL:FIXNUM (CL:LOGAND CODE *INTEGER-UNSIGNED-BITS-MASK*))
    SIZE)))

;;; (DEFUN (ROTATE-HASH-CODE INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM) CL:FIXNUM) ROTATE-HASH-CODE))
(CL:DEFUN ROTATE-HASH-CODE (ARG)
  "Rotate `arg' to the right by 1 position.  This means shift `arg' to the right
by one and feed in `arg's bit zero from the left.  In Lisp the result will stay
in positive FIXNUM range.  In C++ and Java this might return a negative
value which might be equal to NULL-INTEGER.  Important: to make this inlinable,
it must be called with an atom (i.e., constant or variable) as its argument.
This function is primarily useful for hashing sequences of items where the hash
code should take the sequential order of elements into account (e.g., lists)."
  (CL:DECLARE (CL:TYPE CL:FIXNUM ARG))
  #+MCL
  (CL:CHECK-TYPE ARG CL:FIXNUM)
  (CL:RETURN-FROM ROTATE-HASH-CODE
   (CL:IF (CL:= (CL:THE CL:FIXNUM (CL:LOGAND ARG 1)) 0)
    (CL:LET ((ARG ARG)) (CL:DECLARE (CL:TYPE CL:FIXNUM ARG))
     (CL:THE CL:FIXNUM
      (CL:LOGAND (CL:THE CL:FIXNUM (CL:ASH ARG -1))
       *INTEGER-UNSIGNED-BITS-MASK*)))
    (CL:THE CL:FIXNUM
     (CL:LOGIOR
      (CL:THE CL:FIXNUM
       (CL:LET ((ARG ARG) (COUNT 1))
        (CL:DECLARE (CL:TYPE CL:FIXNUM ARG COUNT))
        (CL:THE CL:FIXNUM (CL:ASH ARG (CL:THE CL:FIXNUM (CL:- COUNT))))))
      *INTEGER-MSB-MASK*)))))

;;; (DEFUN (OBJECT-HASH-CODE INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:T) CL:FIXNUM) OBJECT-HASH-CODE))
(CL:DEFUN OBJECT-HASH-CODE (SELF)
  "Return a hash code for `self' (can be negative).  Two objects that are `eq?'
are guaranteed to generate the same hash code.  Two objects that are not `eq?'
do not necessarily generate different hash codes.  Similar to `hash-code' but
always hashes on the address of `self' even if it is a wrapper."
  (CL:RETURN-FROM OBJECT-HASH-CODE (STELLA::%%OBJECT-HASH-CODE SELF)))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(CL:DEFMETHOD HASH-CODE ((SELF OBJECT))
  "Return a hash code for `self' (can be negative).  Two objects that are `eql?'
are guaranteed to generate the same hash code.  Two objects that are not `eql?'
do not necessarily generate different hash codes."
  (CL:RETURN-FROM HASH-CODE
   (CL:LET ((SELF SELF)) (CL:THE CL:FIXNUM (STELLA::%%OBJECT-HASH-CODE SELF)))))

;;; (DEFUN (SAFE-HASH-CODE INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:T) CL:FIXNUM) SAFE-HASH-CODE))
(CL:DEFUN SAFE-HASH-CODE (SELF)
  "Return a hash code for `self'.  Just like `hash-code'
- which see, but also works for NULL."
  (CL:IF (CL:EQ SELF NULL) (CL:RETURN-FROM SAFE-HASH-CODE 63842277)
   (CL:RETURN-FROM SAFE-HASH-CODE (HASH-CODE SELF))))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(%%DEFCONSMETHOD HASH-CODE ((SELF STANDARD-OBJECT))
  (CL:RETURN-FROM HASH-CODE
   (CL:LET ((SELF SELF)) (CL:THE CL:FIXNUM (STELLA::%%OBJECT-HASH-CODE SELF)))))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(CL:DEFMETHOD HASH-CODE ((SELF WRAPPER))
  (CL:LET* ((STREAM-000 (NEW-OUTPUT-STRING-STREAM)))
   (%%PRINT-STREAM (%NATIVE-STREAM STREAM-000)
    "WRAPPER.hash-code: Don't know how to hash on `" SELF "'")
   (CL:ERROR (NEW-STELLA-EXCEPTION (THE-STRING-READER STREAM-000)))))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(CL:DEFMETHOD HASH-CODE ((SELF STRING-WRAPPER))
  (CL:RETURN-FROM HASH-CODE
   (CL:THE CL:FIXNUM
    (CL:SXHASH (CL:THE CL:SIMPLE-STRING (%WRAPPER-VALUE SELF))))))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(CL:DEFMETHOD HASH-CODE ((SELF INTEGER-WRAPPER))
  (CL:RETURN-FROM HASH-CODE (%WRAPPER-VALUE SELF)))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(CL:DEFMETHOD HASH-CODE ((SELF FLOAT-WRAPPER))
  (CL:RETURN-FROM HASH-CODE
   (CL:THE CL:FIXNUM
    (CL:SXHASH (CL:THE CL:DOUBLE-FLOAT (%WRAPPER-VALUE SELF))))))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(CL:DEFMETHOD HASH-CODE ((SELF CHARACTER-WRAPPER))
  (CL:RETURN-FROM HASH-CODE
   (CL:THE CL:FIXNUM
    (CL:LOGXOR
     (CL:THE CL:FIXNUM
      (CL:AREF *HASH-BYTE-RANDOM-TABLE*
       (CL:THE CL:FIXNUM (CL:CHAR-CODE (%WRAPPER-VALUE SELF)))))
     15119378))))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(CL:DEFMETHOD HASH-CODE ((SELF BOOLEAN-WRAPPER))
  (CL:RETURN-FROM HASH-CODE (CL:IF (%WRAPPER-VALUE SELF) 7333705 1891526)))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(CL:DEFMETHOD HASH-CODE ((SELF CL:STRING))
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-STRING)
  (CL:RETURN-FROM HASH-CODE (CL:SXHASH SELF)))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(CL:DEFMETHOD HASH-CODE ((SELF CL:INTEGER))
  (CL:DECLARE (CL:TYPE CL:FIXNUM SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:FIXNUM)
  (CL:RETURN-FROM HASH-CODE SELF))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(CL:DEFMETHOD HASH-CODE ((SELF CL:FLOAT))
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT SELF))
  #+MCL
  (CL:CHECK-TYPE SELF CL:DOUBLE-FLOAT)
  (CL:RETURN-FROM HASH-CODE (CL:SXHASH SELF)))

;;; (DEFMETHOD (HASH-CODE INTEGER) ...)

(CL:DEFMETHOD HASH-CODE ((SELF CL:CHARACTER))
  (CL:RETURN-FROM HASH-CODE
   (CL:THE CL:FIXNUM
    (CL:LOGXOR
     (CL:THE CL:FIXNUM
      (CL:AREF *HASH-BYTE-RANDOM-TABLE*
       (CL:THE CL:FIXNUM (CL:CHAR-CODE SELF))))
     15119378))))

;;; (DEFMETHOD (EQUAL-HASH-CODE INTEGER) ...)

(CL:DEFMETHOD EQUAL-HASH-CODE ((SELF OBJECT))
  "Return a hash code for `self' (can be negative).  Two objects that are `equal?'
are guaranteed to generate the same hash code (provided, that writers of
`object-equal?' methods also implemented the appropriate `equal-hash-code'
method).  Two objects that are not `equal?'do not necessarily generate different
hash codes."
  (CL:RETURN-FROM EQUAL-HASH-CODE (HASH-CODE SELF)))

;;; (DEFUN (SAFE-EQUAL-HASH-CODE INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:T) CL:FIXNUM) SAFE-EQUAL-HASH-CODE))
(CL:DEFUN SAFE-EQUAL-HASH-CODE (SELF)
  "Return a hash code for `self'.  Just like `equal-hash-code'
- which see, but also works for NULL.  `equal-hash-code' methods that expect to
handle NULL components should use this function for recursive calls."
  (CL:IF (CL:EQ SELF NULL) (CL:RETURN-FROM SAFE-EQUAL-HASH-CODE 16569644)
   (CL:RETURN-FROM SAFE-EQUAL-HASH-CODE (EQUAL-HASH-CODE SELF))))

;;; (DEFUN (HASH-STRING INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:SIMPLE-STRING CL:FIXNUM) CL:FIXNUM) HASH-STRING))
(CL:DEFUN HASH-STRING (STRING SEEDCODE)
  "Generate a hash-code for `string' and return it.
Two strings that are equal but not eq will generate the same code.
The hash-code is based on `seedCode' which usually will be 0.  However,
`seedCode' can also be used to supply the result of a previous hash
operation to achieve hashing on sequences of strings without actually
having to concatenate them."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING STRING) (CL:TYPE CL:FIXNUM SEEDCODE))
  #+MCL
  (CL:CHECK-TYPE STRING CL:SIMPLE-STRING)
  #+MCL
  (CL:CHECK-TYPE SEEDCODE CL:FIXNUM)
  (CL:LET* ((CODE SEEDCODE) (CURSOR (CL:THE CL:FIXNUM (CL:LENGTH STRING))))
   (CL:DECLARE (CL:TYPE CL:FIXNUM CODE CURSOR))
   (CL:IF (CL:= CURSOR 0) (CL:RETURN-FROM HASH-STRING 4303803)
    (CL:SETQ CURSOR (CL:1- CURSOR)))
   (CL:LOOP
    (CL:SETQ CODE
     (CL:THE CL:FIXNUM
      (CL:LOGXOR CODE
       (CL:THE CL:FIXNUM
        (CL:AREF *HASH-BYTE-RANDOM-TABLE*
         (CL:THE CL:FIXNUM
          (CL:CHAR-CODE
           (CL:LET ((SELF STRING) (POSITION CURSOR))
            (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING SELF)
             (CL:TYPE CL:FIXNUM POSITION))
            (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF)
             (CL:THE CL:FIXNUM POSITION))))))))))
    (CL:IF (CL:= CURSOR 0) (CL:RETURN) (CL:SETQ CURSOR (CL:1- CURSOR)))
    (CL:SETQ CODE
     (CL:IF (CL:= (CL:THE CL:FIXNUM (CL:LOGAND CODE 1)) 0)
      (CL:LET ((ARG CODE)) (CL:DECLARE (CL:TYPE CL:FIXNUM ARG))
       (CL:THE CL:FIXNUM
        (CL:LOGAND (CL:THE CL:FIXNUM (CL:ASH ARG -1))
         *INTEGER-UNSIGNED-BITS-MASK*)))
      (CL:THE CL:FIXNUM
       (CL:LOGIOR
        (CL:THE CL:FIXNUM
         (CL:LET ((ARG CODE) (COUNT 1))
          (CL:DECLARE (CL:TYPE CL:FIXNUM ARG COUNT))
          (CL:THE CL:FIXNUM (CL:ASH ARG (CL:THE CL:FIXNUM (CL:- COUNT))))))
        *INTEGER-MSB-MASK*)))))
   (CL:RETURN-FROM HASH-STRING CODE)))

;;; (DEFGLOBAL *HASH-TABLE-SIZE-PRIME-STRINGS* ...)

(CL:DEFVAR *HASH-TABLE-SIZE-PRIME-STRINGS* NULL
  "List of prime numbers approximately growing by a factor of 2
that are suitable to be used as hash table sizes.  This is in string
format to enable processing by Lisps with different fixnum sizes.")

;;; (DEFGLOBAL *HASH-TABLE-SIZE-PRIMES* ...)

(CL:DEFVAR *HASH-TABLE-SIZE-PRIMES* NULL
  "List of prime numbers approximately growing by a factor of 2
that are suitable to be used as hash table sizes.")

;;; (DEFUN (PICK-HASH-TABLE-SIZE-PRIME INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:FIXNUM) CL:FIXNUM) PICK-HASH-TABLE-SIZE-PRIME))
(CL:DEFUN PICK-HASH-TABLE-SIZE-PRIME (MINSIZE)
  "Return a hash table prime of at least `minSize'."
  (CL:DECLARE (CL:TYPE CL:FIXNUM MINSIZE))
  #+MCL
  (CL:CHECK-TYPE MINSIZE CL:FIXNUM)
  (CL:LET*
   ((PRIME NULL) (VECTOR-000 *HASH-TABLE-SIZE-PRIMES*) (INDEX-000 0)
    (LENGTH-000 (LENGTH VECTOR-000)))
   (CL:DECLARE (CL:TYPE CL:FIXNUM INDEX-000 LENGTH-000))
   (CL:LOOP WHILE (CL:< INDEX-000 LENGTH-000) DO
    (CL:SETQ PRIME
     (CL:AREF (CL:THE CL:SIMPLE-VECTOR (%THE-ARRAY VECTOR-000)) INDEX-000))
    (CL:WHEN (CL:>= (%WRAPPER-VALUE PRIME) MINSIZE)
     (CL:RETURN-FROM PICK-HASH-TABLE-SIZE-PRIME (%WRAPPER-VALUE PRIME)))
    (CL:SETQ INDEX-000 (CL:1+ INDEX-000))))
  (CL:ERROR
   (NEW-STELLA-EXCEPTION
    "pick-hash-table-size-prime: minimum size is too large")))

;;; (DEFMETHOD INITIALIZE-VECTOR ...)

(CL:DEFMETHOD INITIALIZE-VECTOR ((SELF VECTOR))
  (CL:LET* ((SIZE (%ARRAY-SIZE SELF))) (CL:DECLARE (CL:TYPE CL:FIXNUM SIZE))
   (CL:SETF (%THE-ARRAY SELF) (CL:MAKE-ARRAY SIZE :INITIAL-ELEMENT NULL))
   (setq size size))
  :VOID)

;;; (DEFUN RESIZE-VECTOR ...)

(CL:DEFUN RESIZE-VECTOR (SELF SIZE)
  "Change the size of `self' to `size'.  If `size' is smaller
than the current size of `self' the vector will be truncated.  Otherwise, 
the internal array of `self' will be grown to `size' and unused elements
will be initialized to NULL."
  (CL:DECLARE (CL:TYPE CL:FIXNUM SIZE))
  #+MCL
  (CL:CHECK-TYPE SIZE CL:FIXNUM)
  (CL:LET*
   ((OLD_SIZE (%ARRAY-SIZE SELF)) (I OLD_SIZE) (OLD_ARRAY (%THE-ARRAY SELF))
    (NEW_ARRAY OLD_ARRAY))
   (CL:DECLARE (CL:TYPE CL:FIXNUM OLD_SIZE I)
    (CL:TYPE CL:SIMPLE-VECTOR OLD_ARRAY NEW_ARRAY))
   (CL:WHEN (CL:= SIZE OLD_SIZE) (CL:RETURN-FROM RESIZE-VECTOR))
   (CL:SETQ NEW_ARRAY (CL:MAKE-ARRAY SIZE :INITIAL-ELEMENT NULL))
   (CL:WHEN (CL:< SIZE OLD_SIZE) (CL:SETQ OLD_SIZE SIZE) (CL:SETQ I OLD_SIZE))
   (CL:LOOP WHILE (CL:>= (CL:SETQ I (CL:1- I)) 0) DO
    (CL:LET ((SELF NEW_ARRAY) (VALUE (CL:AREF OLD_ARRAY I)) (POSITION I))
     (CL:DECLARE (CL:TYPE CL:SIMPLE-VECTOR SELF) (CL:TYPE CL:FIXNUM POSITION))
     (CL:SETF (CL:AREF SELF POSITION) VALUE)))
   (setq i i) (CL:SETF (%THE-ARRAY SELF) NEW_ARRAY)
   (CL:SETF (%ARRAY-SIZE SELF) SIZE))
  :VOID)

;;; (DEFMETHOD (NTH (LIKE (ANY-VALUE SELF))) ...)

(CL:DEFMETHOD NTH ((SELF CL:VECTOR) POSITION)
  "Return the element in `self' at `position'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-VECTOR SELF) (CL:TYPE CL:FIXNUM POSITION))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-VECTOR)
  #+MCL
  (CL:CHECK-TYPE POSITION CL:FIXNUM)
  (CL:RETURN-FROM NTH (CL:AREF SELF POSITION)))

;;; (DEFMETHOD (NTH-SETTER (LIKE (ANY-VALUE SELF))) ...)

(CL:DEFMETHOD NTH-SETTER ((SELF CL:VECTOR) VALUE POSITION)
  "Set the element in `self' at `position' to `value'."
  (CL:DECLARE (CL:TYPE CL:SIMPLE-VECTOR SELF) (CL:TYPE CL:FIXNUM POSITION))
  #+MCL
  (CL:CHECK-TYPE SELF CL:SIMPLE-VECTOR)
  #+MCL
  (CL:CHECK-TYPE POSITION CL:FIXNUM)
  (CL:RETURN-FROM NTH-SETTER (CL:SETF (CL:AREF SELF POSITION) VALUE)))

;;; (DEFUN UNMAKE ...)

(CL:DEFUN UNMAKE (SELF)
  (CL:SETQ SELF SELF)
  :VOID)

;;; (DEFUN COPY-FILE ...)

(CL:DEFUN COPY-FILE (FROMFILE TOFILE)
  "Copy file `fromFile' to file `toFile', clobbering
any data already in `toFile'."
  (ENSURE-FILE-EXISTS FROMFILE "copy-file")
  (CL:LET* ((FROM NULL))
   (CL:UNWIND-PROTECT
    (CL:PROGN (CL:SETQ FROM (OPEN-INPUT-FILE FROMFILE))
     (CL:LET* ((TO NULL))
      (CL:UNWIND-PROTECT
       (CL:PROGN (CL:SETQ TO (OPEN-OUTPUT-FILE TOFILE))
        (CL:LET*
         ((BUFFER (CL:MAKE-STRING *TOKENIZER-INITIAL-BUFFER-SIZE*))
          (BYTES-READ 0))
         (CL:DECLARE (CL:TYPE CL:FIXNUM BYTES-READ))
         (CL:LOOP
          (CL:SETQ BYTES-READ
           (NATIVE-BYTE-ARRAY-READ-SEQUENCE BUFFER (%NATIVE-STREAM FROM) 0
            *TOKENIZER-INITIAL-BUFFER-SIZE*))
          (CL:IF (CL:> BYTES-READ 0)
           (NATIVE-BYTE-ARRAY-WRITE-SEQUENCE BUFFER (%NATIVE-STREAM TO) 0
            BYTES-READ)
           (CL:RETURN)))))
       (CL:WHEN (CL:NOT (CL:EQ TO NULL)) (FREE TO)))))
    (CL:WHEN (CL:NOT (CL:EQ FROM NULL)) (FREE FROM))))
  :VOID)

;;; (DEFUN (LOGNOT INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM) CL:FIXNUM) LOGNOT))
(CL:DEFUN LOGNOT (ARG)
  (CL:DECLARE (CL:TYPE CL:FIXNUM ARG))
  #+MCL
  (CL:CHECK-TYPE ARG CL:FIXNUM)
  (CL:RETURN-FROM LOGNOT (CL:LOGNOT ARG)))

;;; (DEFUN (LOGAND INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) LOGAND))
(CL:DEFUN LOGAND (ARG1 ARG2)
  (CL:DECLARE (CL:TYPE CL:FIXNUM ARG1 ARG2))
  #+MCL
  (CL:CHECK-TYPE ARG1 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE ARG2 CL:FIXNUM)
  (CL:RETURN-FROM LOGAND (CL:LOGAND ARG1 ARG2)))

;;; (DEFUN (LOGOR INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) LOGOR))
(CL:DEFUN LOGOR (ARG1 ARG2)
  (CL:DECLARE (CL:TYPE CL:FIXNUM ARG1 ARG2))
  #+MCL
  (CL:CHECK-TYPE ARG1 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE ARG2 CL:FIXNUM)
  (CL:RETURN-FROM LOGOR (CL:LOGIOR ARG1 ARG2)))

;;; (DEFUN (LOGXOR INTEGER) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) LOGXOR))
(CL:DEFUN LOGXOR (ARG1 ARG2)
  (CL:DECLARE (CL:TYPE CL:FIXNUM ARG1 ARG2))
  #+MCL
  (CL:CHECK-TYPE ARG1 CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE ARG2 CL:FIXNUM)
  (CL:RETURN-FROM LOGXOR (CL:LOGXOR ARG1 ARG2)))

;;; (DEFUN (SHIFT-LEFT INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) SHIFT-LEFT))
(CL:DEFUN SHIFT-LEFT (ARG COUNT)
  (CL:DECLARE (CL:TYPE CL:FIXNUM ARG COUNT))
  #+MCL
  (CL:CHECK-TYPE ARG CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE COUNT CL:FIXNUM)
  (CL:RETURN-FROM SHIFT-LEFT (CL:ASH ARG COUNT)))

;;; (DEFUN (SHIFT-RIGHT INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:FIXNUM CL:FIXNUM) CL:FIXNUM) SHIFT-RIGHT))
(CL:DEFUN SHIFT-RIGHT (ARG COUNT)
  "Shift `arg' to the right by `count' positions and
0-extend from the left if `arg' is positive or 1-extend if it is
negative.  This is an arithmetic shift that preserve the sign of `arg'
and is equivalent to dividing `arg' by 2** `count'."
  (CL:DECLARE (CL:TYPE CL:FIXNUM ARG COUNT))
  #+MCL
  (CL:CHECK-TYPE ARG CL:FIXNUM)
  #+MCL
  (CL:CHECK-TYPE COUNT CL:FIXNUM)
  (CL:RETURN-FROM SHIFT-RIGHT (CL:ASH ARG (CL:THE CL:FIXNUM (CL:- COUNT)))))

;;; (DEFUN (UNSIGNED-SHIFT-RIGHT-BY-1 INTEGER) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION (CL:FIXNUM) CL:FIXNUM) UNSIGNED-SHIFT-RIGHT-BY-1))
(CL:DEFUN UNSIGNED-SHIFT-RIGHT-BY-1 (ARG)
  "Shift `arg' to the right by 1 position and 0-extend
from the left.  This does not preserve the sign of `arg' and shifts
the sign-bit just like a regular bit.  In Common-Lisp we can't do that
directly and need to do some extra masking."
  (CL:DECLARE (CL:TYPE CL:FIXNUM ARG))
  #+MCL
  (CL:CHECK-TYPE ARG CL:FIXNUM)
  (CL:RETURN-FROM UNSIGNED-SHIFT-RIGHT-BY-1
   (CL:LOGAND (CL:THE CL:FIXNUM (CL:ASH ARG -1)) *INTEGER-UNSIGNED-BITS-MASK*)))

;;; (DEFUN (GENERATE-UUID STRING) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:T) CL:SIMPLE-STRING) GENERATE-UUID))
(CL:DEFUN GENERATE-UUID (UUID-TYPE)
  "Generates a UUID of the specified type.  Legal types are
a subset of the IETF RFC 4122 (see http://www.ietf.org/rfc/rfc4122.txt )
UUID types.  Currently supported are:
    :TYPE-4  :RANDOM       A type-4 (random) UUID.  These are synonyms."
  (CL:COND
   ((CL:OR (CL:EQ UUID-TYPE KWD-PRIMAL-TYPE-4)
     (CL:EQ UUID-TYPE KWD-PRIMAL-RANDOM))
    (CL:RETURN-FROM GENERATE-UUID (GENERATE-RANDOM-UUID)))
   (CL:T
    (CL:LET* ((STREAM-000 (NEW-OUTPUT-STRING-STREAM)))
     (%%PRINT-STREAM (%NATIVE-STREAM STREAM-000) "UUIDs of type `" UUID-TYPE
      "' are not supported.")
     (CL:ERROR (NEW-STELLA-EXCEPTION (THE-STRING-READER STREAM-000)))))))

;;; (DEFUN (GENERATE-RANDOM-UUID STRING) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION () CL:SIMPLE-STRING) GENERATE-RANDOM-UUID))
(CL:DEFUN GENERATE-RANDOM-UUID ()
  "Generates a random UUID (Type 4), according to the guidelines
of IETF RFC 4122 (see http://www.ietf.org/rfc/rfc4122.txt )

Take 16 random bytes (octets), put them all behind each other, for the description
the numbering starts with byte 1 (most significant, first) to byte 16 
   (least significant, last). Then put in the version and variant.
To put in the version, take the 7th byte and perform an and operation using 0x0f,
   followed by an or operation with 0x40. 
To put in the variant, take the 9th byte and perform an and operation using 0x3f,
   followed by an or operation with 0x80.
To make the string representation, take the hexadecimal presentation of bytes 1-4
   (without 0x in front of it) let them follow by a -, then take bytes 5 and 6, - 
bytes 7 and 8, - bytes 9 and 10, - then followed by bytes 11-16."
  (CL:RETURN-FROM GENERATE-RANDOM-UUID
   (CONCATENATE (ZERO-PAD-STRING (INTEGER-TO-HEX-STRING (RANDOM 65536)) 4)
    (ZERO-PAD-STRING (INTEGER-TO-HEX-STRING (RANDOM 65536)) 4) "-"
    (ZERO-PAD-STRING (INTEGER-TO-HEX-STRING (RANDOM 65536)) 4) "-"
    (INTEGER-TO-HEX-STRING (CL:+ 16384 (RANDOM 4096))) "-"
    (INTEGER-TO-HEX-STRING (CL:+ 32768 (RANDOM 16384))) "-"
    (ZERO-PAD-STRING (INTEGER-TO-HEX-STRING (RANDOM 16777216)) 6)
    (ZERO-PAD-STRING (INTEGER-TO-HEX-STRING (RANDOM 16777216)) 6))))

;;; (DEFUN (STELLIFY OBJECT) ...)

(CL:DEFUN STELLIFY (SELF)
  "Convert a Lisp object into a STELLA object."
  (CL:LET* ((RESULT SELF)) (CL:typecase self
        (CL:NULL (cl:setq result STELLA::NIL))
        (CL:CONS (cl:setq result (stella::cons (stellify (CL:car self))
                                               (stellify (CL:cdr self)))))
        (CL:KEYWORD (cl:setq result (intern-keyword (CL:symbol-name self))))
        (CL:SYMBOL
         (CL:if (cl:eq self CL:t)
           (cl:setq result TRUE-WRAPPER)
           (cl:setq result (intern-symbol (CL:symbol-name self)))))
        ((CL:or CL:NUMBER CL:STRING) (cl:setq result (wrap-literal self)))
        (STELLA::OBJECT (cl:setq result self))
        (CL:t (CL:error "Can't stellify: " self)))
   (CL:RETURN-FROM STELLIFY RESULT)))

;;; (DEFUN (STELLA-OBJECT? BOOLEAN) ...)

(CL:DEFUN STELLA-OBJECT? (SELF)
  "Return true if `self' is a member of the STELLA class `OBJECT'."
  (CL:LET* ((RESULT? CL:T))
   (CL:setq result? (CL:or (CL:typep self 'STELLA::OBJECT)
                               (CL:listp self)))
   (CL:RETURN-FROM STELLA-OBJECT? RESULT?)))

;;; (DEFUN (RUNNING-AS-LISP? BOOLEAN) ...)

(CL:DEFUN RUNNING-AS-LISP? ()
  "Return true if the executable code is a Common Lisp application."
  (CL:LET* ((RESULT? CL:NIL)) (cl:setq result? TRUE)
   (CL:RETURN-FROM RUNNING-AS-LISP? RESULT?)))

;;; (DEFUN (RUNNING-IN-LANGUAGE KEYWORD) ...)

(CL:DEFUN RUNNING-IN-LANGUAGE ()
  "Returns the keyword for the language the current implementation is running in."
  (CL:RETURN-FROM RUNNING-IN-LANGUAGE (INTERN-KEYWORD "COMMON-LISP")))

;;; (DEFUN (RUNNING-SYSTEM-INFORMATION STRING) ...)

(CL:DECLAIM
 (CL:FTYPE (CL:FUNCTION () CL:SIMPLE-STRING) RUNNING-SYSTEM-INFORMATION))
(CL:DEFUN RUNNING-SYSTEM-INFORMATION ()
  "Returns an information string about the current running system environment."
  (CL:LET* ((INFO "")) (CL:DECLARE (CL:TYPE CL:SIMPLE-STRING INFO))
   (cl:setq info (cl:format cl:nil "~%    Lisp: ~@[~A~] ~@[~A~]~%      OS: ~@[~A~] ~@[~A~]~%Hardware: ~@[~A~] ~@[~A~]"
             (cl:lisp-implementation-type)
             (cl:lisp-implementation-version)
             (cl:software-type)
             (cl:software-version)
             (cl:machine-type)
             (cl:machine-version)))
   (CL:RETURN-FROM RUNNING-SYSTEM-INFORMATION INFO)))

;;; (DEFUN SLEEP ...)

(CL:DEFUN SLEEP (SECONDS)
  "The program will sleep for the indicated number of seconds.
Fractional values are allowed, but the results are implementation dependent:
Common Lisp uses the fractions natively, Java with a resolution of 0.001,
and C++ can only use integral values."
  (CL:DECLARE (CL:TYPE CL:DOUBLE-FLOAT SECONDS))
  #+MCL
  (CL:CHECK-TYPE SECONDS CL:DOUBLE-FLOAT)
  (cl:sleep seconds)
  :VOID)

;;; (DEFUN (EXCEPTION-MESSAGE STRING) ...)

(CL:DECLAIM (CL:FTYPE (CL:FUNCTION (CL:T) CL:SIMPLE-STRING) EXCEPTION-MESSAGE))
(CL:DEFUN EXCEPTION-MESSAGE (E)
  "Accesses the error message of the exception `e'."
  (CL:RETURN-FROM EXCEPTION-MESSAGE (%%GET-EXCEPTION-MESSAGE E)))

;;; (DEFUN PRINT-EXCEPTION-CONTEXT ...)

(CL:DEFUN PRINT-EXCEPTION-CONTEXT (E STREAM)
  "Prints a system dependent information about the context of the specified
exception.  For example, in Java it prints a stack trace.  In Lisp, it is vendor dependent."
  (CL:LET* ((S (%NATIVE-STREAM STREAM))) (%%PRINT-EXCEPTION-CONTEXT E S))
  :VOID)

;;; (DEFUN (MAKE-PROCESS-LOCK PROCESS-LOCK-OBJECT) ...)

(CL:DEFUN MAKE-PROCESS-LOCK ()
  (CL:RETURN-FROM MAKE-PROCESS-LOCK (%make-process-lock)))

;;; (DEFGLOBAL *BOOTSTRAP-LOCK* ...)

(CL:DEFVAR *BOOTSTRAP-LOCK* (%make-process-lock)
  "Process lock object for bootstrap use.")

(CL:DEFUN HELP-STARTUP-PRIMAL1 ()
  (CL:PROGN
   (CL:SETQ SYM-PRIMAL-STELLA-FLOOR
    (INTERN-RIGID-SYMBOL-WRT-MODULE "FLOOR" NULL 0))
   (CL:SETQ KWD-PRIMAL-CPP (INTERN-RIGID-SYMBOL-WRT-MODULE "CPP" NULL 2))
   (CL:SETQ KWD-PRIMAL-FUNCTION
    (INTERN-RIGID-SYMBOL-WRT-MODULE "FUNCTION" NULL 2))
   (CL:SETQ SYM-PRIMAL-STELLA-ROUND
    (INTERN-RIGID-SYMBOL-WRT-MODULE "ROUND" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-FMOD
    (INTERN-RIGID-SYMBOL-WRT-MODULE "FMOD" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-RANDOM
    (INTERN-RIGID-SYMBOL-WRT-MODULE "RANDOM" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-SQRT
    (INTERN-RIGID-SYMBOL-WRT-MODULE "SQRT" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-COS
    (INTERN-RIGID-SYMBOL-WRT-MODULE "COS" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-SIN
    (INTERN-RIGID-SYMBOL-WRT-MODULE "SIN" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-TAN
    (INTERN-RIGID-SYMBOL-WRT-MODULE "TAN" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-ACOS
    (INTERN-RIGID-SYMBOL-WRT-MODULE "ACOS" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-ASIN
    (INTERN-RIGID-SYMBOL-WRT-MODULE "ASIN" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-ATAN
    (INTERN-RIGID-SYMBOL-WRT-MODULE "ATAN" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-ATAN2
    (INTERN-RIGID-SYMBOL-WRT-MODULE "ATAN2" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-EXP
    (INTERN-RIGID-SYMBOL-WRT-MODULE "EXP" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-LOG
    (INTERN-RIGID-SYMBOL-WRT-MODULE "LOG" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-MIN
    (INTERN-RIGID-SYMBOL-WRT-MODULE "MIN" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-MAX
    (INTERN-RIGID-SYMBOL-WRT-MODULE "MAX" NULL 0))
   (CL:SETQ KWD-PRIMAL-UPCASE
    (INTERN-RIGID-SYMBOL-WRT-MODULE "UPCASE" NULL 2))
   (CL:SETQ KWD-PRIMAL-DOWNCASE
    (INTERN-RIGID-SYMBOL-WRT-MODULE "DOWNCASE" NULL 2))
   (CL:SETQ KWD-PRIMAL-CAPITALIZE
    (INTERN-RIGID-SYMBOL-WRT-MODULE "CAPITALIZE" NULL 2))
   (CL:SETQ KWD-PRIMAL-PRESERVE
    (INTERN-RIGID-SYMBOL-WRT-MODULE "PRESERVE" NULL 2))
   (CL:SETQ KWD-PRIMAL-LEFT (INTERN-RIGID-SYMBOL-WRT-MODULE "LEFT" NULL 2))
   (CL:SETQ KWD-PRIMAL-RIGHT (INTERN-RIGID-SYMBOL-WRT-MODULE "RIGHT" NULL 2))
   (CL:SETQ KWD-PRIMAL-CENTER
    (INTERN-RIGID-SYMBOL-WRT-MODULE "CENTER" NULL 2))
   (CL:SETQ KWD-PRIMAL-WHITE-SPACE
    (INTERN-RIGID-SYMBOL-WRT-MODULE "WHITE-SPACE" NULL 2))
   (CL:SETQ SYM-PRIMAL-STELLA-HASH-CODE
    (INTERN-RIGID-SYMBOL-WRT-MODULE "HASH-CODE" NULL 0))
   (CL:SETQ KWD-PRIMAL-JAVA (INTERN-RIGID-SYMBOL-WRT-MODULE "JAVA" NULL 2))
   (CL:SETQ KWD-PRIMAL-TYPE-4
    (INTERN-RIGID-SYMBOL-WRT-MODULE "TYPE-4" NULL 2))
   (CL:SETQ KWD-PRIMAL-RANDOM
    (INTERN-RIGID-SYMBOL-WRT-MODULE "RANDOM" NULL 2))
   (CL:SETQ SYM-PRIMAL-STELLA-SLEEP
    (INTERN-RIGID-SYMBOL-WRT-MODULE "SLEEP" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-STARTUP-PRIMAL
    (INTERN-RIGID-SYMBOL-WRT-MODULE "STARTUP-PRIMAL" NULL 0))
   (CL:SETQ SYM-PRIMAL-STELLA-METHOD-STARTUP-CLASSNAME
    (INTERN-RIGID-SYMBOL-WRT-MODULE "METHOD-STARTUP-CLASSNAME" NULL 0)))
  :VOID)

(CL:DEFUN HELP-STARTUP-PRIMAL2 ()
  (CL:PROGN
   (DEFINE-FUNCTION-OBJECT "LISP-NULL-ARRAY-SYMBOL-STRING"
    "(DEFUN (LISP-NULL-ARRAY-SYMBOL-STRING STRING) ((RANK INTEGER)))"
    (CL:FUNCTION LISP-NULL-ARRAY-SYMBOL-STRING) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NULL? BOOLEAN) ((X UNKNOWN)) :DOCUMENTATION \"Return true if `x' is undefined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NULL? BOOLEAN) ((X OBJECT)) :DOCUMENTATION \"Return true if `x' is undefined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NULL? BOOLEAN) ((X SECOND-CLASS-OBJECT)) :DOCUMENTATION \"Return true if `x' is undefined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NULL? BOOLEAN) ((X NATIVE-VECTOR)) :DOCUMENTATION \"Return true if `x' is undefined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NULL? BOOLEAN) ((X ARRAY)) :DOCUMENTATION \"Return true if `x' is undefined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NULL? BOOLEAN) ((X STRING)) :DOCUMENTATION \"Return true if `x' is undefined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NULL? BOOLEAN) ((X MUTABLE-STRING)) :DOCUMENTATION \"Return true if `x' is undefined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NULL? BOOLEAN) ((X CHARACTER)) :DOCUMENTATION \"Return true if `x' is undefined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NULL? BOOLEAN) ((X CODE)) :DOCUMENTATION \"Return true if `x' is undefined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NULL? BOOLEAN) ((X INTEGER)) :DOCUMENTATION \"Return true if `x' is undefined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NULL? BOOLEAN) ((X FLOAT)) :DOCUMENTATION \"Return true if `x' is undefined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (DEFINED? BOOLEAN) ((X UNKNOWN)) :DOCUMENTATION \"Return true if `x' is defined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (DEFINED? BOOLEAN) ((X OBJECT)) :DOCUMENTATION \"Return true if `x' is defined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (DEFINED? BOOLEAN) ((X SECOND-CLASS-OBJECT)) :DOCUMENTATION \"Return true if `x' is defined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (DEFINED? BOOLEAN) ((X NATIVE-VECTOR)) :DOCUMENTATION \"Return true if `x' is defined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (DEFINED? BOOLEAN) ((X ARRAY)) :DOCUMENTATION \"Return true if `x' is defined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (DEFINED? BOOLEAN) ((X STRING)) :DOCUMENTATION \"Return true if `x' is defined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (DEFINED? BOOLEAN) ((X MUTABLE-STRING)) :DOCUMENTATION \"Return true if `x' is defined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (DEFINED? BOOLEAN) ((X CHARACTER)) :DOCUMENTATION \"Return true if `x' is defined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (DEFINED? BOOLEAN) ((X CODE)) :DOCUMENTATION \"Return true if `x' is defined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (DEFINED? BOOLEAN) ((X INTEGER)) :DOCUMENTATION \"Return true if `x' is defined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (DEFINED? BOOLEAN) ((X FLOAT)) :DOCUMENTATION \"Return true if `x' is defined (handled specially by all translators).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "EQ?"
    "(DEFUN (EQ? BOOLEAN) ((X UNKNOWN) (Y UNKNOWN)) :DOCUMENTATION \"Return true if `x' and `y' are literally the same object (or
simple number).  Analogue to the Common Lisp EQL and C++ and Java's ==.\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "="
    "(DEFUN (= BOOLEAN) ((X NUMBER) (Y NUMBER)) :DOCUMENTATION \"Return true if `x' and `y' are numbers of exactly the same magnitude.\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "EQL?"
    "(DEFUN (EQL? BOOLEAN) ((X OBJECT) (Y OBJECT)) :DOCUMENTATION \"Return true if `x' and `y' are `eq?' or equivalent literals
such as strings that also might be wrapped in non-identical wrappers.  For
the case where `x' or `y' are plain literals such as strings or integers, the
STELLA translator substitutes the equality test appropriate for the particular
target language and does not actually call this function.  For cases where
`x' or `y' are known to be of type STANDARD-OBJECT, the STELLA translator
substitutes the faster `eq?' test inline.\" :PUBLIC? TRUE)" (CL:FUNCTION EQL?)
    NULL)
   (DEFINE-FUNCTION-OBJECT "EQUAL?"
    "(DEFUN (EQUAL? BOOLEAN) ((X OBJECT) (Y OBJECT)) :DOCUMENTATION \"Return true if `x' and `y' are `eql?' or considered equal
by a user-defined `object-equal?' method.  This implements a fully extensible
equality test similar to Java's `equals' method.  Note that writers of custom
`object-equal?' methods must also implement a corresponding `equal-hash-code'
method.\" :PUBLIC? TRUE)" (CL:FUNCTION EQUAL?) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (OBJECT-EQUAL? BOOLEAN) ((X OBJECT) (Y OBJECT)) :DOCUMENTATION \"Return true if `x' and `y' are `eq?'.\" :PUBLIC? TRUE)"
    (CL:FUNCTION OBJECT-EQUAL?) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (OBJECT-EQUAL? BOOLEAN) ((X WRAPPER) (Y OBJECT)) :DOCUMENTATION \"Return true if `x' and `y' are literal wrappers whose
literals are considered `eql?'.\" :PUBLIC? TRUE)" (CL:FUNCTION OBJECT-EQUAL?)
    NULL)
   (DEFINE-FUNCTION-OBJECT ">"
    "(DEFUN (> BOOLEAN) ((X NUMBER) (Y NUMBER)) :DOCUMENTATION \"Return true if `x' is greater than `y'.\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT ">="
    "(DEFUN (>= BOOLEAN) ((X NUMBER) (Y NUMBER)) :DOCUMENTATION \"Return true if `x' is greater than or equal to `y'.\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "<"
    "(DEFUN (< BOOLEAN) ((X NUMBER) (Y NUMBER)) :DOCUMENTATION \"Return true if `x' is less than `y'.\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "<="
    "(DEFUN (<= BOOLEAN) ((X NUMBER) (Y NUMBER)) :DOCUMENTATION \"Return true if `x' is less than or equal to `y'.\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "+"
    "(DEFUN (+ NUMBER) (|&REST| (ARGUMENTS NUMBER)) :DOCUMENTATION \"Return the sum of all `arguments'.\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "-"
    "(DEFUN (- NUMBER) ((X NUMBER) |&REST| (ARGUMENTS NUMBER)) :DOCUMENTATION \"If only `x' was supplied return the result of 0 - `x'.
Otherwise, return the result of (...((`x' - arg1) - arg2) - ... - argN).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "*"
    "(DEFUN (* NUMBER) (|&REST| (ARGUMENTS NUMBER)) :DOCUMENTATION \"Return the product of all `arguments'.\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "/"
    "(DEFUN (/ NUMBER) ((X NUMBER) |&REST| (ARGUMENTS NUMBER)) :DOCUMENTATION \"If only `x' was supplied return the result of 1 / `x'.
Otherwise, return the result of (...((`x' / arg1) / arg2 ) / ... / argN).\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "ZERO?"
    "(DEFUN (ZERO? BOOLEAN) ((X INTEGER)) :DOCUMENTATION \"Return true if `x' is 0.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:= X 0) :CPP \"(!x)\" :JAVA \"(x == 0)\")))"
    (CL:FUNCTION ZERO?) NULL)
   (DEFINE-FUNCTION-OBJECT "PLUS?"
    "(DEFUN (PLUS? BOOLEAN) ((X INTEGER)) :DOCUMENTATION \"Return true if `x' is greater than 0.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:> X 0) :CPP \"(x > 0)\" :JAVA \"(x > 0)\")))"
    (CL:FUNCTION PLUS?) NULL)
   (DEFINE-FUNCTION-OBJECT "EVEN?"
    "(DEFUN (EVEN? BOOLEAN) ((X INTEGER)) :DOCUMENTATION \"Return true if `x' is an even number.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:NOT (CL:LOGBITP 0 X)) :CPP \"!(x % 2)\" :JAVA \"((x % 2) == 0)\")))"
    (CL:FUNCTION EVEN?) NULL)
   (DEFINE-FUNCTION-OBJECT "ODD?"
    "(DEFUN (ODD? BOOLEAN) ((X INTEGER)) :DOCUMENTATION \"Return true if `x' is an odd number.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:LOGBITP 0 X) :CPP \"(x % 2)\" :JAVA \"((x % 2) == 1)\")))"
    (CL:FUNCTION ODD?) NULL)
   (DEFINE-FUNCTION-OBJECT "DIV"
    "(DEFUN (DIV INTEGER) ((X INTEGER) (Y INTEGER)) :DOCUMENTATION \"Return the integer quotient from dividing `x' by `y'.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:VALUES (CL:TRUNCATE X Y)) :CPP \"(x / y)\" :JAVA \"(x / y)\")))"
    (CL:FUNCTION DIV) NULL)
   (DEFINE-FUNCTION-OBJECT "REM"
    "(DEFUN (REM INTEGER) ((X INTEGER) (Y INTEGER)) :DOCUMENTATION \"Return the remainder from dividing `x' by `y'.  The
sign of the result is always the same as the sign of `x'.  This has slightly
different behavior than the `mod' function, and has less overhead in C++ and
Java, which don't have direct support for a true modulus function.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:REM X Y) :CPP \"(x % y)\" :JAVA \"(x % y)\")))"
    (CL:FUNCTION REM) NULL)
   (DEFINE-FUNCTION-OBJECT "FREM"
    "(DEFUN (FREM FLOAT) ((X FLOAT) (Y FLOAT)) :DOCUMENTATION \"Return the floating point remainder from dividing `x' by `y'.  The
sign of the result is always the same as the sign of `x'.  This has slightly
different behavior than the `mod' function, and has less overhead in C++ and
Java, which don't have direct support for a true modulus function.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:REM X Y) :CPP \"fmod(x, y)\" :JAVA \"(x % y)\")))"
    (CL:FUNCTION FREM) NULL)
   (DEFINE-FUNCTION-OBJECT "MOD"
    "(DEFUN (MOD INTEGER) ((X INTEGER) (MODULUS INTEGER)) :DOCUMENTATION \"True modulus.  Return the result of `x' mod `modulo'.
Note: In C++ and Java, `mod' has more overhead than the similar
function `rem'.  The  answers returned by `mod' and `rem' are only
different when the signs of `x' and `modulo' are different.\" :PUBLIC? TRUE)"
    (CL:FUNCTION MOD) NULL)
   (DEFINE-FUNCTION-OBJECT "FMOD"
    "(DEFUN (FMOD FLOAT) ((X FLOAT) (MODULUS FLOAT)) :DOCUMENTATION \"True modulus for floats.  Return the result of `x' mod `modulo'.
Note: In C++ and Java, `mod' has more overhead than the similar
function `rem'.  The  answers returned by `mod' and `rem' are only
different when the signs of `x' and `modulo' are different.\" :PUBLIC? TRUE)"
    (CL:FUNCTION FMOD) NULL)
   (DEFINE-FUNCTION-OBJECT "GCD"
    "(DEFUN (GCD INTEGER) ((X INTEGER) (Y INTEGER)) :DOCUMENTATION \"Return the greatest common divisor of `x' and `y'.\" :PUBLIC? TRUE)"
    (CL:FUNCTION GCD) NULL)
   (DEFINE-FUNCTION-OBJECT "CEILING"
    "(DEFUN (CEILING INTEGER) ((N NUMBER)) :DOCUMENTATION \"Return the smallest integer >= `n'.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "FLOOR"
    "(DEFUN (FLOOR INTEGER) ((N NUMBER)) :DOCUMENTATION \"Return the biggest integer <= `n'.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "ROUND"
    "(DEFUN (ROUND INTEGER) ((N NUMBER)) :DOCUMENTATION \"Round `n' to the closest integer and return the result.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "TRUNCATE"
    "(DEFUN (TRUNCATE INTEGER) ((N NUMBER)) :DOCUMENTATION \"Truncate `n' toward zero and return the result.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "INTEGER-VALUED?"
    "(DEFUN (INTEGER-VALUED? BOOLEAN) ((X FLOAT)) :DOCUMENTATION \"Returns `true' if `x' is the floating point representation of an integer.\" :PUBLIC? TRUE)"
    (CL:FUNCTION INTEGER-VALUED?) NULL)
   (DEFINE-FUNCTION-OBJECT "FLOAT-TO-BASE60"
    "(DEFUN (FLOAT-TO-BASE60 (CONS OF NUMBER-WRAPPER)) ((X FLOAT) (ALL-INTEGERS? BOOLEAN)) :DOCUMENTATION \"Returns a cons of `x' in a base-60 form.  That means
the first value will be the integer part of `x', the next value
the iteger value of the fraction part of `x' times 60 and the
third value the fraction part of `x' time 3600.  If `all-integers?'
is `true', then the last value will be rounded to an integer.
This can be used to convert from decimal degree values to Degree-Minute-Second
or from decimal hours to Hour-Minute-Second format.\" :PUBLIC? TRUE)"
    (CL:FUNCTION FLOAT-TO-BASE60) NULL)
   (DEFINE-FUNCTION-OBJECT "BASE60-TO-FLOAT"
    "(DEFUN (BASE60-TO-FLOAT FLOAT) ((L (CONS OF NUMBER-WRAPPER))) :DOCUMENTATION \"Converts (x y z) into a float.  The return value
is x + y/60 + z/3600.
This can be used to convert from Degree-Minute-Second to decimal degrees
or from Hour-Minute-Second format to decimal hours.\")"
    (CL:FUNCTION BASE60-TO-FLOAT) NULL)
   (DEFINE-FUNCTION-OBJECT "RANDOM"
    "(DEFUN (RANDOM INTEGER) ((N INTEGER)) :PUBLIC? TRUE :DOCUMENTATION \"Generate a random integer in the interval [0..n-1].\")"
    (CL:FUNCTION RANDOM) NULL)
   (DEFINE-FUNCTION-OBJECT "SEED-RANDOM-NUMBER-GENERATOR"
    "(DEFUN SEED-RANDOM-NUMBER-GENERATOR () :PUBLIC? TRUE :DOCUMENTATION \"Seeds the random number generator with the current time.\")"
    (CL:FUNCTION SEED-RANDOM-NUMBER-GENERATOR) NULL)
   (DEFINE-FUNCTION-OBJECT "SQRT"
    "(DEFUN (SQRT FLOAT) ((N FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return the square root of `n'.\" (RETURN (VERBATIM :COMMON-LISP (CL:SQRT N) :CPP \"::sqrt(n)\" :JAVA \"Math.sqrt(n)\")))"
    (CL:FUNCTION SQRT) NULL)
   (DEFINE-FUNCTION-OBJECT "COS"
    "(DEFUN (COS FLOAT) ((N FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return the cosine of `n' radians.\" (RETURN (VERBATIM :COMMON-LISP (CL:COS N) :CPP \"::cos(n)\" :JAVA \"Math.cos(n)\")))"
    (CL:FUNCTION COS) NULL)
   (DEFINE-FUNCTION-OBJECT "SIN"
    "(DEFUN (SIN FLOAT) ((N FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return the sine of `n' radians.\" (RETURN (VERBATIM :COMMON-LISP (CL:SIN N) :CPP \"::sin(n)\" :JAVA \"Math.sin(n)\")))"
    (CL:FUNCTION SIN) NULL)
   (DEFINE-FUNCTION-OBJECT "TAN"
    "(DEFUN (TAN FLOAT) ((N FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return the tangent of `n' radians.\" (RETURN (VERBATIM :COMMON-LISP (CL:TAN N) :CPP \"::tan(n)\" :JAVA \"Math.tan(n)\")))"
    (CL:FUNCTION TAN) NULL))
  :VOID)

(CL:DEFUN HELP-STARTUP-PRIMAL3 ()
  (CL:PROGN
   (DEFINE-FUNCTION-OBJECT "ACOS"
    "(DEFUN (ACOS FLOAT) ((N FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return the arccosine of `n' in radians.\" (RETURN (VERBATIM :COMMON-LISP (CL:ACOS N) :CPP \"::acos(n)\" :JAVA \"Math.acos(n)\")))"
    (CL:FUNCTION ACOS) NULL)
   (DEFINE-FUNCTION-OBJECT "ASIN"
    "(DEFUN (ASIN FLOAT) ((N FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return the arcsine of `n' in radians.\" (RETURN (VERBATIM :COMMON-LISP (CL:ASIN N) :CPP \"::asin(n)\" :JAVA \"Math.asin(n)\")))"
    (CL:FUNCTION ASIN) NULL)
   (DEFINE-FUNCTION-OBJECT "ATAN"
    "(DEFUN (ATAN FLOAT) ((N FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return the arc tangent of `n' in radians.\" (RETURN (VERBATIM :COMMON-LISP (CL:ATAN N) :CPP \"::atan(n)\" :JAVA \"Math.atan(n)\")))"
    (CL:FUNCTION ATAN) NULL)
   (DEFINE-FUNCTION-OBJECT "ATAN2"
    "(DEFUN (ATAN2 FLOAT) ((X FLOAT) (Y FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return the arc tangent of `x' / `y' in radians.\" (RETURN (VERBATIM :COMMON-LISP (CL:ATAN X Y) :CPP \"::atan2(x,y)\" :JAVA \"Math.atan2(x,y)\")))"
    (CL:FUNCTION ATAN2) NULL)
   (DEFINE-FUNCTION-OBJECT "LOG"
    "(DEFUN (LOG FLOAT) ((N FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return the natural logarithm (base e) of `n'.\" (RETURN (VERBATIM :COMMON-LISP (CL:LOG N) :CPP \"::log(n)\" :JAVA \"Math.log(n)\")))"
    (CL:FUNCTION LOG) NULL)
   (DEFINE-FUNCTION-OBJECT "LOG10"
    "(DEFUN (LOG10 FLOAT) ((N FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return the logarithm (base 10) of `n'.\" (RETURN (VERBATIM :COMMON-LISP (CL:LOG N 10.0D0) :OTHERWISE (* (LOG N) RECIPROCAL-NL10))))"
    (CL:FUNCTION LOG10) NULL)
   (DEFINE-FUNCTION-OBJECT "EXP"
    "(DEFUN (EXP FLOAT) ((N FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return the e to the power `n'.\" (RETURN (VERBATIM :COMMON-LISP (CL:EXP N) :CPP \"::exp(n)\" :JAVA \"Math.exp(n)\")))"
    (CL:FUNCTION EXP) NULL)
   (DEFINE-FUNCTION-OBJECT "EXPT"
    "(DEFUN (EXPT FLOAT) ((X FLOAT) (Y FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Return `x' ^ `y'.\" (RETURN (VERBATIM :COMMON-LISP (CL:EXPT X Y) :CPP \"::pow(x,y)\" :JAVA \"Math.pow(x,y)\")))"
    (CL:FUNCTION EXPT) NULL)
   (DEFINE-FUNCTION-OBJECT "MIN"
    "(DEFUN (MIN INTEGER) ((X INTEGER) (Y INTEGER)) :DOCUMENTATION \"Return the minimum of `x' and `y'.  If either is NULL, return the other.\" :PUBLIC? TRUE)"
    (CL:FUNCTION MIN) NULL)
   (DEFINE-FUNCTION-OBJECT "MAX"
    "(DEFUN (MAX INTEGER) ((X INTEGER) (Y INTEGER)) :DOCUMENTATION \"Return the maximum of `x' and `y'.  If either is NULL, return the other.\" :PUBLIC? TRUE)"
    (CL:FUNCTION MAX) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (ABS INTEGER) ((X INTEGER)) :DOCUMENTATION \"Return the absolute value of `x'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (CHOOSE (< X 0) (- 0 X) X)))"
    (CL:FUNCTION ABS) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (ABS FLOAT) ((X FLOAT)) :DOCUMENTATION \"Return the absolute value of `x'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (CHOOSE (< X 0.0) (- 0.0 X) X)))"
    (CL:FUNCTION ABS) NULL)
   (DEFINE-FUNCTION-OBJECT "CHARACTER-CODE"
    "(DEFUN (CHARACTER-CODE INTEGER) ((CH CHARACTER)) :DOCUMENTATION \"Return the 8-bit ASCII code of `ch' as an integer.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:CHAR-CODE CH) :CPP \"(int)(unsigned char) ch\" :JAVA \"(int) ch\")))"
    (CL:FUNCTION CHARACTER-CODE) NULL)
   (DEFINE-FUNCTION-OBJECT "CODE-CHARACTER"
    "(DEFUN (CODE-CHARACTER CHARACTER) ((CODE INTEGER)) :DOCUMENTATION \"Return the character encoded by `code' (0 <= `code' <= 255).\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:CODE-CHAR CODE) :CPP \"(char) code\" :JAVA \"(char) code\")))"
    (CL:FUNCTION CODE-CHARACTER) NULL)
   (DEFINE-FUNCTION-OBJECT "CHARACTER-DOWNCASE"
    "(DEFUN (CHARACTER-DOWNCASE CHARACTER) ((CH CHARACTER)) :DOCUMENTATION \"If `ch' is lowercase, return its uppercase version,
otherwise, return 'ch' unmodified.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (DOWNCASE-CHARACTER CH)))"
    (CL:FUNCTION CHARACTER-DOWNCASE) NULL)
   (DEFINE-FUNCTION-OBJECT "CHARACTER-UPCASE"
    "(DEFUN (CHARACTER-UPCASE CHARACTER) ((CH CHARACTER)) :DOCUMENTATION \"If `ch' is uppercase, return its lowercase version,
otherwise, return 'ch' unmodified.  If only the first character of
a sequence of characters is to be capitalized, `character-capitalize'
should be used instead.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (UPCASE-CHARACTER CH)))"
    (CL:FUNCTION CHARACTER-UPCASE) NULL)
   (DEFINE-FUNCTION-OBJECT "CHARACTER-CAPITALIZE"
    "(DEFUN (CHARACTER-CAPITALIZE CHARACTER) ((CH CHARACTER)) :DOCUMENTATION \"Return the capitalized character for `ch'.  This is generally the same
as the uppercase character, except for obscure non-English characters in Java.  It should
be used if only the first character of a sequence of characters is to be capitalized.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :JAVA \"Character.toTitleCase(ch)\" :OTHERWISE (CHARACTER-UPCASE CH))))"
    (CL:FUNCTION CHARACTER-CAPITALIZE) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-EQL?"
    "(DEFUN (STRING-EQL? BOOLEAN) ((X STRING) (Y STRING)) :DOCUMENTATION \"Return true if `x' and `y' are equal strings or are both undefined.  This
test is substituted automatically by the STELLA translator if `eql?' is applied
to strings.\" :PUBLIC? TRUE)" (CL:FUNCTION STRING-EQL?) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-EQUAL?"
    "(DEFUN (STRING-EQUAL? BOOLEAN) ((X STRING) (Y STRING)) :DOCUMENTATION \"Return true if `x' and `y' are equal strings ignoring character case or
are both undefined.\" :PUBLIC? TRUE)" (CL:FUNCTION STRING-EQUAL?) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-COMPARE"
    "(DEFUN (STRING-COMPARE INTEGER) ((X STRING) (Y STRING) (CASE-SENSITIVE? BOOLEAN)) :PUBLIC? TRUE :DOCUMENTATION \"Compare `x' and `y' lexicographically, and return -1, 0, 
or 1, depending on whether `x' is less than, equal, or greater than `y'.
If `case-sensitive?' is true, then case does matter for the comparison\")"
    (CL:FUNCTION STRING-COMPARE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (EMPTY? BOOLEAN) ((X STRING)) :DOCUMENTATION \"Return true if `x' is the empty string \\\"\\\"\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (STRING-EQL? X \"\")))"
    (CL:FUNCTION EMPTY?) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NON-EMPTY? BOOLEAN) ((X STRING)) :DOCUMENTATION \"Return true if `x' is not the empty string \\\"\\\"\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (NOT (EMPTY? X))))"
    (CL:FUNCTION NON-EMPTY?) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (EMPTY? BOOLEAN) ((X STRING-WRAPPER)) :DOCUMENTATION \"Return true if `x' is the wrapped empty string \\\"\\\"\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (STRING-EQL? (WRAPPER-VALUE X) \"\")))"
    (CL:FUNCTION EMPTY?) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NON-EMPTY? BOOLEAN) ((X STRING-WRAPPER)) :DOCUMENTATION \"Return true if `x' is not the wrapped empty string \\\"\\\"\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (NOT (EMPTY? X))))"
    (CL:FUNCTION NON-EMPTY?) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING<"
    "(DEFUN (STRING< BOOLEAN) ((X STRING) (Y STRING)) :PUBLIC? TRUE :DOCUMENTATION \"Return true if `x' is lexicographically < `y', considering case.\")"
    (CL:FUNCTION STRING<) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING<="
    "(DEFUN (STRING<= BOOLEAN) ((X STRING) (Y STRING)) :PUBLIC? TRUE :DOCUMENTATION \"Return true if `x' is lexicographically <= `y', considering case.\")"
    (CL:FUNCTION STRING<=) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING>="
    "(DEFUN (STRING>= BOOLEAN) ((X STRING) (Y STRING)) :PUBLIC? TRUE :DOCUMENTATION \"Return true if `x' is lexicographically >= `y', considering case.\")"
    (CL:FUNCTION STRING>=) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING>"
    "(DEFUN (STRING> BOOLEAN) ((X STRING) (Y STRING)) :PUBLIC? TRUE :DOCUMENTATION \"Return true if `x' is lexicographically > `y', considering case.\")"
    (CL:FUNCTION STRING>) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-LESS?"
    "(DEFUN (STRING-LESS? BOOLEAN) ((X STRING) (Y STRING)) :PUBLIC? TRUE :DOCUMENTATION \"Return true if `x' is lexicographically < `y', ignoring case.\")"
    (CL:FUNCTION STRING-LESS?) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-LESS-EQUAL?"
    "(DEFUN (STRING-LESS-EQUAL? BOOLEAN) ((X STRING) (Y STRING)) :PUBLIC? TRUE :DOCUMENTATION \"Return true if `x' is lexicographically <= `y', ignoring case.\")"
    (CL:FUNCTION STRING-LESS-EQUAL?) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-GREATER-EQUAL?"
    "(DEFUN (STRING-GREATER-EQUAL? BOOLEAN) ((X STRING) (Y STRING)) :PUBLIC? TRUE :DOCUMENTATION \"Return true if `x' is lexicographically >= `y', ignoring case.\")"
    (CL:FUNCTION STRING-GREATER-EQUAL?) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-GREATER?"
    "(DEFUN (STRING-GREATER? BOOLEAN) ((X STRING) (Y STRING)) :PUBLIC? TRUE :DOCUMENTATION \"Return true if `x' is lexicographically > `y', ignoring case.\")"
    (CL:FUNCTION STRING-GREATER?) NULL)
   (DEFINE-FUNCTION-OBJECT "MAKE-STRING"
    "(DEFUN (MAKE-STRING STRING) ((SIZE INTEGER) (INITCHAR CHARACTER)) :DOCUMENTATION \"Return a new string filled with `size' `initchar's.\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "MAKE-MUTABLE-STRING"
    "(DEFUN (MAKE-MUTABLE-STRING MUTABLE-STRING) ((SIZE INTEGER) (INITCHAR CHARACTER)) :DOCUMENTATION \"Return a new mutable string filled with `size' `initchar's.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:MAKE-STRING SIZE :INITIAL-ELEMENT INITCHAR) :CPP \"makeString(size, initchar)\" :JAVA \"#$(STELLAROOT).javalib.Native.makeMutableString(size, initchar)\")))"
    (CL:FUNCTION MAKE-MUTABLE-STRING) NULL)
   (DEFINE-FUNCTION-OBJECT "MAKE-RAW-MUTABLE-STRING"
    "(DEFUN (MAKE-RAW-MUTABLE-STRING MUTABLE-STRING) ((SIZE INTEGER)) :DOCUMENTATION \"Return a new uninitialized mutable string of `size'.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (LET ((S MUTABLE-STRING NULL)) (VERBATIM :COMMON-LISP (SETQ S (CL:MAKE-STRING SIZE)) :CPP \"s = new (GC) char[size+1]; s[size]='\\\\0'\" :JAVA \"s = new StringBuffer(size); s.setLength(size)\") (RETURN S)))"
    (CL:FUNCTION MAKE-RAW-MUTABLE-STRING) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-CONCATENATE"
    "(DEFUN (STRING-CONCATENATE STRING) ((STRING1 STRING) (STRING2 STRING)) :DOCUMENTATION \"Return a new string representing the concatenation of
`string1' and `string2'.\" :NATIVE? TRUE)" NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (CONCATENATE STRING) ((STRING1 STRING) (STRING2 STRING) |&REST| (OTHERSTRINGS STRING)) :PUBLIC? TRUE :DOCUMENTATION \"Return a new string representing the concatenation
of `string1', `string2', and `otherStrings'.  The two mandatory parameters
allow us to optimize the common binary case by not relying on the somewhat
less efficient variable arguments mechanism.\")" (CL:FUNCTION CONCATENATE)
    NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-UPCASE"
    "(DEFUN (STRING-UPCASE STRING) ((STRING STRING)) :DOCUMENTATION \"Return an upper-case copy of `string'.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-DOWNCASE"
    "(DEFUN (STRING-DOWNCASE STRING) ((STRING STRING)) :DOCUMENTATION \"Return a lower-case copy of `string'.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-CAPITALIZE"
    "(DEFUN (STRING-CAPITALIZE STRING) ((STRING STRING)) :DOCUMENTATION \"Return a capitalized version of `string'.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (COPY STRING) ((STRING STRING)) :DOCUMENTATION \"Return a copy of `string'.\" :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (SUBSTITUTE STRING) ((SELF STRING) (NEW-CHAR CHARACTER) (OLD-CHAR CHARACTER)) :DOCUMENTATION \"Substitute all occurences of `old-char' with `new-char'
in the string `self'.\" :NATIVE? TRUE :PUBLIC? TRUE)" NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (SUBSTITUTE MUTABLE-STRING) ((SELF MUTABLE-STRING) (NEW-CHAR CHARACTER) (OLD-CHAR CHARACTER)) :DOCUMENTATION \"Substitute all occurences of `old-char' with `new-char'
in the string `self'.\" :NATIVE? TRUE :PUBLIC? TRUE)" NULL NULL)
   (DEFINE-FUNCTION-OBJECT "HELP-SUBSTITUTE-CHARACTERS"
    "(DEFUN (HELP-SUBSTITUTE-CHARACTERS MUTABLE-STRING) ((SELF MUTABLE-STRING) (NEW-CHARS STRING) (OLD-CHARS STRING)) :PUBLIC? FALSE :GLOBALLY-INLINE? TRUE (LET ((POS INTEGER NULL)) (FOREACH I IN (INTERVAL 0 (1- (LENGTH SELF))) DO (SETQ POS (POSITION OLD-CHARS (NTH SELF I) 0)) (WHEN (DEFINED? POS) (SETF (NTH SELF I) (NTH NEW-CHARS POS)))) (RETURN SELF)))"
    (CL:FUNCTION HELP-SUBSTITUTE-CHARACTERS) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (SUBSTITUTE-CHARACTERS MUTABLE-STRING) ((SELF MUTABLE-STRING) (NEW-CHARS STRING) (OLD-CHARS STRING)) :DOCUMENTATION \"Substitute all occurences of of a member of `old-chars' with the 
corresponding member of `new-chars' in the string `self'.  IMPORTANT:  The return
value should be used instead of relying on destructive substitution, since the
substitution will not be destructive in all translated languages.\" :PUBLIC? TRUE)"
    (CL:FUNCTION SUBSTITUTE-CHARACTERS) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (SUBSTITUTE-CHARACTERS STRING) ((SELF STRING) (NEW-CHARS STRING) (OLD-CHARS STRING)) :DOCUMENTATION \"Substitute all occurences of of a member of `old-chars' with the 
corresponding member of `new-chars' in the string `self'.  Returns a new string.\" :PUBLIC? TRUE)"
    (CL:FUNCTION SUBSTITUTE-CHARACTERS) NULL)
   (DEFINE-FUNCTION-OBJECT "REPLACE-SUBSTRINGS"
    "(DEFUN (REPLACE-SUBSTRINGS STRING) ((STRING STRING) (NEW STRING) (OLD STRING)) :DOCUMENTATION \"Replace all occurrences of `old' in `string' with `new'.\" :PUBLIC? TRUE)"
    (CL:FUNCTION REPLACE-SUBSTRINGS) NULL)
   (DEFINE-FUNCTION-OBJECT "INSTANTIATE-STRING-TEMPLATE"
    "(DEFUN (INSTANTIATE-STRING-TEMPLATE STRING) ((TEMPLATE STRING) |&REST| (|VARS&VALUES| STRING)) :DOCUMENTATION \"For each occurrence of a <var> string from `vars&values' in `template' replace it
with its corresponding <value> string.  Replacement is done in sequence which
means (part of) a value might be replaced further with a later <var> and <value>.\" :PUBLIC? TRUE)"
    (CL:FUNCTION INSTANTIATE-STRING-TEMPLATE) NULL)
   (DEFINE-FUNCTION-OBJECT "INSERT-STRING"
    "(DEFUN (INSERT-STRING INTEGER) ((SOURCE STRING) (START INTEGER) (END INTEGER) (TARGET MUTABLE-STRING) (TARGET-INDEX INTEGER) (CASE-CONVERSION KEYWORD)) :DOCUMENTATION \"Inserts characters from `source' begining at `start' and
ending at `end' into `target' starting at `target-index'.  If `end' is `null',
then the entire length of the string is used. The copy of characters is affected
by the `case-conversion' keyword which should be one of
   :UPCASE :DOWNCASE :CAPITALIZE :PRESERVE.

The final value of target-index is returned.\")" (CL:FUNCTION INSERT-STRING)
    NULL)
   (DEFINE-FUNCTION-OBJECT "INTEGER-TO-STRING"
    "(DEFUN (INTEGER-TO-STRING STRING) ((I INTEGER)) :DOCUMENTATION \"Convert `i' to its string representation and return the result.
 This is more efficient than using a string stream.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "INTEGER-TO-HEX-STRING"
    "(DEFUN (INTEGER-TO-HEX-STRING STRING) ((I INTEGER)) :DOCUMENTATION \"Convert `i' to a string representation in hexadecimal notation and return the result.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "INTEGER-TO-STRING-IN-BASE"
    "(DEFUN (INTEGER-TO-STRING-IN-BASE STRING) ((I INTEGER) (BASE INTEGER)) :DOCUMENTATION \"Convert `i' to a string representation in `base' and return the
result.  `base' must be positive and not more than 36.

Note that in the C++ version, only 8, 10 and 16 will work as `base' arguments,
since that is all the underlying implementation supports.  Other argument
values will be treated as `10'.\" :NATIVE? TRUE :PUBLIC? TRUE)" NULL NULL)
   (DEFINE-FUNCTION-OBJECT "FLOAT-TO-STRING"
    "(DEFUN (FLOAT-TO-STRING STRING) ((F FLOAT)) :DOCUMENTATION \"Convert `f' to its string representation and return the result.  This is more
efficient than using a string stream.\" :NATIVE? TRUE :PUBLIC? TRUE)" NULL
    NULL)
   (DEFINE-FUNCTION-OBJECT "CHARACTER-TO-STRING"
    "(DEFUN (CHARACTER-TO-STRING STRING) ((C CHARACTER)) :DOCUMENTATION \"Convert `c' into a one-element string and return the result.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (MAKE-STRING 1 C)))"
    (CL:FUNCTION CHARACTER-TO-STRING) NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-TO-INTEGER"
    "(DEFUN (STRING-TO-INTEGER INTEGER) ((STRING STRING)) :DOCUMENTATION \"Convert a `string' representation of an integer into an integer.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-TO-FLOAT"
    "(DEFUN (STRING-TO-FLOAT FLOAT) ((STRING STRING)) :DOCUMENTATION \"Convert a `string' representation of a float into a float.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "FORMAT-FLOAT"
    "(DEFUN (FORMAT-FLOAT STRING) ((F FLOAT) (NDECIMALS INTEGER)) :DOCUMENTATION \"Print `f' in fixed-point format with `nDecimals' behind the decimal point
and return the result as a string.\" :NATIVE? TRUE :PUBLIC? TRUE)" NULL NULL)
   (DEFINE-FUNCTION-OBJECT "FORMAT-WITH-PADDING"
    "(DEFUN (FORMAT-WITH-PADDING STRING) ((INPUT STRING) (LENGTH INTEGER) (PADCHAR CHARACTER) (ALIGN KEYWORD) (TRUNCATE? BOOLEAN)) :PUBLIC? TRUE :DOCUMENTATION \"Formats `input' to be (at least) `length' long, using `padchar' to
fill if necessary.  `align' must be one of :LEFT, :RIGHT, :CENTER and will control
how `input' will be justified in the resulting string.  If `truncate?' is true, then
then an overlength string will be truncated, using the opposite of `align' to pick
the truncation direction.\")" (CL:FUNCTION FORMAT-WITH-PADDING) NULL)
   (DEFINE-FUNCTION-OBJECT "ZERO-PAD-INTEGER"
    "(DEFUN (ZERO-PAD-INTEGER STRING) ((VALUE INTEGER) (SIZE INTEGER)) :PUBLIC? TRUE :DOCUMENTATION \"Returns a string representing `value' of at least length
'size', padded if necessary with 0 characters.\")"
    (CL:FUNCTION ZERO-PAD-INTEGER) NULL)
   (DEFINE-FUNCTION-OBJECT "ZERO-PAD-STRING"
    "(DEFUN (ZERO-PAD-STRING STRING) ((INPUT STRING) (SIZE INTEGER)) :PUBLIC? FALSE)"
    (CL:FUNCTION ZERO-PAD-STRING) NULL))
  :VOID)

(CL:DEFUN HELP-STARTUP-PRIMAL4 ()
  (CL:PROGN
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (MEMBER? BOOLEAN) ((SELF STRING) (CHAR CHARACTER)) :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (FIRST CHARACTER) ((SELF STRING)) :DOCUMENTATION \"Return the first character of `self'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (NTH SELF 0)))"
    (CL:FUNCTION FIRST) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (FIRST CHARACTER) ((SELF MUTABLE-STRING)) :DOCUMENTATION \"Return the first character of `self' (settable via `setf').\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (NTH SELF 0)))"
    (CL:FUNCTION FIRST) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (FIRST-SETTER CHARACTER) ((SELF MUTABLE-STRING) (CH CHARACTER)) :DOCUMENTATION \"Set the first character of `self' to `ch' and return `ch'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (SETF (NTH SELF 0) CH)))"
    (CL:FUNCTION FIRST-SETTER) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (SECOND CHARACTER) ((SELF STRING)) :DOCUMENTATION \"Return the second character of `self'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (NTH SELF 1)))"
    (CL:FUNCTION SECOND) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (SECOND CHARACTER) ((SELF MUTABLE-STRING)) :DOCUMENTATION \"Return the second character of `self' (settable via `setf').\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (NTH SELF 1)))"
    (CL:FUNCTION SECOND) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (SECOND-SETTER CHARACTER) ((SELF MUTABLE-STRING) (CH CHARACTER)) :DOCUMENTATION \"Set the second character of `self' to `ch' and return `ch'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (SETF (NTH SELF 1) CH)))"
    (CL:FUNCTION SECOND-SETTER) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (THIRD CHARACTER) ((SELF STRING)) :DOCUMENTATION \"Return the third character of `self'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (NTH SELF 2)))"
    (CL:FUNCTION THIRD) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (THIRD CHARACTER) ((SELF MUTABLE-STRING)) :DOCUMENTATION \"Return the third character of `self' (settable via `setf').\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (NTH SELF 2)))"
    (CL:FUNCTION THIRD) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (THIRD-SETTER CHARACTER) ((SELF MUTABLE-STRING) (CH CHARACTER)) :DOCUMENTATION \"Set the third character of `self' to `ch' and return `ch'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (SETF (NTH SELF 2) CH)))"
    (CL:FUNCTION THIRD-SETTER) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (FOURTH CHARACTER) ((SELF STRING)) :DOCUMENTATION \"Return the fourth character of `self'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (NTH SELF 3)))"
    (CL:FUNCTION FOURTH) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (FOURTH CHARACTER) ((SELF MUTABLE-STRING)) :DOCUMENTATION \"Return the fourth character of `self' (settable via `setf').\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (NTH SELF 3)))"
    (CL:FUNCTION FOURTH) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (FOURTH-SETTER CHARACTER) ((SELF MUTABLE-STRING) (CH CHARACTER)) :DOCUMENTATION \"Set the fourth character of `self' to `ch' and return `ch'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (SETF (NTH SELF 3) CH)))"
    (CL:FUNCTION FOURTH-SETTER) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (FIFTH CHARACTER) ((SELF STRING)) :DOCUMENTATION \"Return the fifth character of `self'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (NTH SELF 4)))"
    (CL:FUNCTION FIFTH) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (FIFTH CHARACTER) ((SELF MUTABLE-STRING)) :DOCUMENTATION \"Return the fifth character of `self' (settable via `setf').\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (NTH SELF 4)))"
    (CL:FUNCTION FIFTH) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (FIFTH-SETTER CHARACTER) ((SELF MUTABLE-STRING) (CH CHARACTER)) :DOCUMENTATION \"Set the fifth character of `self' to `ch' and return `ch'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (SETF (NTH SELF 4) CH)))"
    (CL:FUNCTION FIFTH-SETTER) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NTH CHARACTER) ((SELF STRING) (POSITION INTEGER)) :DOCUMENTATION \"Return the character in `self' at `position'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)) :CPP \"self[position]\" :JAVA \"self.charAt(position)\")))"
    (CL:FUNCTION NTH) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NTH CHARACTER) ((SELF MUTABLE-STRING) (POSITION INTEGER)) :DOCUMENTATION \"Return the character in `self' at `position'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)) :CPP \"self[position]\" :JAVA \"self.charAt(position)\")))"
    (CL:FUNCTION NTH) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NTH-SETTER CHARACTER) ((SELF MUTABLE-STRING) (CH CHARACTER) (POSITION INTEGER)) :DOCUMENTATION \"Set the character in `self' at `position' to `ch'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (VERBATIM :COMMON-LISP (SETF (CL:SCHAR (CL:THE CL:SIMPLE-STRING SELF) (CL:THE CL:FIXNUM POSITION)) (CL:THE CL:CHARACTER CH)) :CPP \"self[position] = ch\" :JAVA \"#$(STELLAROOT).javalib.Native.mutableString_nthSetter(self, ch, position)\")))"
    (CL:FUNCTION NTH-SETTER) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (REST STRING) ((SELF STRING)) :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (LENGTH INTEGER) ((SELF STRING)) :DOCUMENTATION \"Return the length of the string `self'.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:LENGTH SELF) :CPP \"strlen(self)\" :JAVA \"self.length()\")))"
    (CL:FUNCTION LENGTH) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (LENGTH INTEGER) ((SELF MUTABLE-STRING)) :DOCUMENTATION \"Return the length of the string `self'.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:LENGTH SELF) :CPP \"strlen(self)\" :JAVA \"self.length()\")))"
    (CL:FUNCTION LENGTH) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (POSITION INTEGER) ((STRING STRING) (CHARACTER CHARACTER) (START INTEGER)) :DOCUMENTATION \"Return the position of `character' within `string' (counting
from zero); or return NULL if `character' does not occur within `string'.
If `start' was supplied as non-NULL, only consider the substring starting
at `start', however, the returned position will always be relative to the
entire string.\" :NATIVE? TRUE :PUBLIC? TRUE)" NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (LAST-POSITION INTEGER) ((STRING STRING) (CHARACTER CHARACTER) (END INTEGER)) :DOCUMENTATION \"Return the last position of `character' within `string'
(counting from zero); or return NULL if `character' does not occur 
within `string'.  If `end' was supplied as non-NULL, only consider
the substring ending at `end', however, the returned position will
always be relative to the entire string.\" :NATIVE? TRUE :PUBLIC? TRUE)" NULL
    NULL)
   (DEFINE-FUNCTION-OBJECT "STRING-SEARCH"
    "(DEFUN (STRING-SEARCH INTEGER) ((STRING STRING) (SUBSTRING STRING) (START INTEGER)) :DOCUMENTATION \"Return start position of the left-most occurrence of
`substring' in `string', beginning from `start'.  Return NULL if it is not
a substring.\" :NATIVE? TRUE :PUBLIC? TRUE)" NULL NULL)
   (DEFINE-FUNCTION-OBJECT "STARTS-WITH?"
    "(DEFUN (STARTS-WITH? BOOLEAN) ((STRING STRING) (PREFIX STRING) (START INTEGER)) :DOCUMENTATION \"Return TRUE if `string' starts with `prefix' starting from
`start' (which defaults to 0 if it is supplied as NULL).\" :PUBLIC? TRUE)"
    (CL:FUNCTION STARTS-WITH?) NULL)
   (DEFINE-FUNCTION-OBJECT "HELP-FIND-MATCHING-PREFIX-LENGTH"
    "(DEFUN (HELP-FIND-MATCHING-PREFIX-LENGTH INTEGER) ((STRING1 STRING) (START1 INTEGER) (END1 INTEGER) (STRING2 STRING) (START2 INTEGER) (END2 INTEGER)) :PUBLIC? FALSE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Helping function for `find-matching-prefix' that requires `end1' and `end2'
to be properly set up.\" (LET ((I1 START1) (I2 START2)) (WHILE (AND (< I1 END1) (< I2 END2) (EQL? (NTH STRING1 I1) (NTH STRING2 I2))) (++ I1) (++ I2)) (RETURN (- I1 START1))))"
    (CL:FUNCTION HELP-FIND-MATCHING-PREFIX-LENGTH) NULL)
   (DEFINE-FUNCTION-OBJECT "FIND-MATCHING-PREFIX-LENGTH"
    "(DEFUN (FIND-MATCHING-PREFIX-LENGTH INTEGER) ((STRING1 STRING) (START1 INTEGER) (END1 INTEGER) (STRING2 STRING) (START2 INTEGER) (END2 INTEGER)) :PUBLIC? TRUE :DOCUMENTATION \"Finds the length of the matching prefix strings of `string1' and
`string2', starting at position `start1' and `start2' respectively.
The search will end when `end1' or `end2' is reached.  If either `end1'
or `end2' is null, then they will be set to the length of their respective
strings.\")" (CL:FUNCTION FIND-MATCHING-PREFIX-LENGTH) NULL)
   (DEFINE-FUNCTION-OBJECT "FIND-MISMATCH"
    "(DEFUN (FIND-MISMATCH INTEGER INTEGER) ((STRING1 STRING) (START1 INTEGER) (END1 INTEGER) (STRING2 STRING) (START2 INTEGER) (END2 INTEGER)) :PUBLIC? TRUE :DOCUMENTATION \"Finds the first position in each of `string1' and `string2' where
they mismatch, starting at position `start1' and `start2' respectively.
The search will end when `end1' or `end2' is reached.  If either `end1'
or `end2' is null, then they will be set to the length of their respective
strings.  If there is no mismatch, then `null' values are returned.\")"
    (CL:FUNCTION FIND-MISMATCH) NULL)
   (DEFINE-FUNCTION-OBJECT "NON-MATCHING-POSITION-HELPER"
    "(DEFUN (NON-MATCHING-POSITION-HELPER INTEGER) ((SOURCE STRING) (START INTEGER) (END INTEGER) (MATCH STRING)) :PUBLIC? FALSE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Helper for `non-matching-position' that requires `end' to not be `null'.\" (WHILE (AND (< START END) (MEMBER? MATCH (NTH SOURCE START))) (++ START)) (RETURN START))"
    (CL:FUNCTION NON-MATCHING-POSITION-HELPER) NULL)
   (DEFINE-FUNCTION-OBJECT "NON-MATCHING-POSITION"
    "(DEFUN (NON-MATCHING-POSITION INTEGER) ((SOURCE STRING) (START INTEGER) (MATCH STRING)) :PUBLIC? TRUE :DOCUMENTATION \"Returns the index into `source', starting from `start', of the first
character that is not included in `match'.\")"
    (CL:FUNCTION NON-MATCHING-POSITION) NULL)
   (DEFINE-FUNCTION-OBJECT "HELP-ADVANCE-PAST-WHITESPACE"
    "(DEFUN (HELP-ADVANCE-PAST-WHITESPACE INTEGER) ((SOURCE STRING) (START INTEGER) (END INTEGER)) :PUBLIC? FALSE :GLOBALLY-INLINE? TRUE :DOCUMENTATION \"Helper for `advance-past-whitespace' that requires `end' to be properly set.\" (WHILE (AND (< START END) (WHITE-SPACE-CHARACTER? (NTH SOURCE START))) (++ START)) (RETURN START))"
    (CL:FUNCTION HELP-ADVANCE-PAST-WHITESPACE) NULL)
   (DEFINE-FUNCTION-OBJECT "ADVANCE-PAST-WHITESPACE"
    "(DEFUN (ADVANCE-PAST-WHITESPACE INTEGER) ((SOURCE STRING) (START INTEGER)) :PUBLIC? TRUE :DOCUMENTATION \"Returns the first index into `source', starting from `start', of
the first character that is not white space.\")"
    (CL:FUNCTION ADVANCE-PAST-WHITESPACE) NULL)
   (DEFINE-FUNCTION-OBJECT "EQL-EXCEPT-IN-WHITESPACE?"
    "(DEFUN (EQL-EXCEPT-IN-WHITESPACE? BOOLEAN) ((S1 STRING) (S2 STRING)) :PUBLIC? TRUE :DOCUMENTATION \"Return `true' if the strings `s1' and `s2' are the same
except for the amounts of whitespace separating words.  Leading or
trailing whitespace is also not considered.\")"
    (CL:FUNCTION EQL-EXCEPT-IN-WHITESPACE?) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (SUBSEQUENCE STRING) ((STRING STRING) (START INTEGER) (END INTEGER)) :DOCUMENTATION \"Return a substring of `string' beginning at position `start'
and ending up to but not including position `end', counting from zero.  An
`end' value of NULL stands for the rest of the string.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (SUBSEQUENCE STRING) ((STRING MUTABLE-STRING) (START INTEGER) (END INTEGER)) :DOCUMENTATION \"Return a substring of `string' beginning at position `start'
and ending up to but not including position `end', counting from zero.  An
`end' value of NULL stands for the rest of the string.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "STRINGIFY"
    "(DEFUN (STRINGIFY STRING) ((EXPRESSION OBJECT)) :DOCUMENTATION \"Print `expression' onto a string and return the result.
Printing is done with `*printReadably?*' set to true and with `*printPretty?*'
set to false.\" :NATIVE? TRUE :PUBLIC? TRUE)" NULL NULL)
   (DEFINE-FUNCTION-OBJECT "UNSTRINGIFY"
    "(DEFUN (UNSTRINGIFY OBJECT) ((STRING STRING)) :DOCUMENTATION \"Read a STELLA expression from `string' and return the result.
This is identical to `read-s-expression-from-string'.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (READ-S-EXPRESSION-FROM-STRING STRING)))"
    (CL:FUNCTION UNSTRINGIFY) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD FREE-HASH-TABLE-VALUES ((SELF ABSTRACT-HASH-TABLE)) :DOCUMENTATION \"Call free on each value in the hash table `self'.\")"
    (CL:FUNCTION FREE-HASH-TABLE-VALUES) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD INITIALIZE-HASH-TABLE ((SELF ABSTRACT-HASH-TABLE)) :DOCUMENTATION \"Insert a newly-created native hash table into `self'.\")"
    (CL:FUNCTION INITIALIZE-HASH-TABLE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (LOOKUP (LIKE (ANY-VALUE SELF))) ((SELF HASH-TABLE) (KEY (LIKE (ANY-KEY SELF)))) :PUBLIC? TRUE)"
    (CL:FUNCTION LOOKUP) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD INSERT-AT ((SELF HASH-TABLE) (KEY (LIKE (ANY-KEY SELF))) (VALUE (LIKE (ANY-VALUE SELF)))) :PUBLIC? TRUE)"
    (CL:FUNCTION INSERT-AT) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD REMOVE-AT ((SELF HASH-TABLE) (KEY (LIKE (ANY-KEY SELF)))) :PUBLIC? TRUE)"
    (CL:FUNCTION REMOVE-AT) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD INITIALIZE-HASH-TABLE ((SELF INTEGER-HASH-TABLE)) :DOCUMENTATION \"Insert a newly-created native hash table into `self'.\")"
    (CL:FUNCTION INITIALIZE-HASH-TABLE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (LOOKUP (LIKE (ANY-VALUE SELF))) ((SELF INTEGER-HASH-TABLE) (KEY INTEGER)) :PUBLIC? TRUE)"
    (CL:FUNCTION LOOKUP) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD INSERT-AT ((SELF INTEGER-HASH-TABLE) (KEY INTEGER) (VALUE OBJECT)) :PUBLIC? TRUE)"
    (CL:FUNCTION INSERT-AT) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD REMOVE-AT ((SELF INTEGER-HASH-TABLE) (KEY (LIKE (ANY-KEY SELF)))))"
    (CL:FUNCTION REMOVE-AT) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD INITIALIZE-HASH-TABLE ((SELF FLOAT-HASH-TABLE)) :DOCUMENTATION \"Insert a newly-created native hash table into `self'.\")"
    (CL:FUNCTION INITIALIZE-HASH-TABLE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (LOOKUP (LIKE (ANY-VALUE SELF))) ((SELF FLOAT-HASH-TABLE) (KEY FLOAT)) :PUBLIC? TRUE)"
    (CL:FUNCTION LOOKUP) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD INSERT-AT ((SELF FLOAT-HASH-TABLE) (KEY FLOAT) (VALUE OBJECT)) :PUBLIC? TRUE)"
    (CL:FUNCTION INSERT-AT) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD REMOVE-AT ((SELF FLOAT-HASH-TABLE) (KEY (LIKE (ANY-KEY SELF)))))"
    (CL:FUNCTION REMOVE-AT) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD INITIALIZE-HASH-TABLE ((SELF STRING-HASH-TABLE)) :DOCUMENTATION \"Insert a newly-created native hash table into `self'.\")"
    (CL:FUNCTION INITIALIZE-HASH-TABLE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (LOOKUP (LIKE (ANY-VALUE SELF))) ((SELF STRING-HASH-TABLE) (KEY STRING)) :PUBLIC? TRUE)"
    (CL:FUNCTION LOOKUP) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD INSERT-AT ((SELF STRING-HASH-TABLE) (KEY STRING) (VALUE OBJECT)) :PUBLIC? TRUE)"
    (CL:FUNCTION INSERT-AT) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD REMOVE-AT ((SELF STRING-HASH-TABLE) (KEY STRING)) :PUBLIC? TRUE)"
    (CL:FUNCTION REMOVE-AT) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD INITIALIZE-HASH-TABLE ((SELF STRING-TO-INTEGER-HASH-TABLE)) :DOCUMENTATION \"Insert a newly-created native hash table into `self'.\")"
    (CL:FUNCTION INITIALIZE-HASH-TABLE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (LOOKUP INTEGER) ((SELF STRING-TO-INTEGER-HASH-TABLE) (KEY STRING)) :PUBLIC? TRUE)"
    (CL:FUNCTION LOOKUP) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD INSERT-AT ((SELF STRING-TO-INTEGER-HASH-TABLE) (KEY STRING) (VALUE INTEGER)) :PUBLIC? TRUE)"
    (CL:FUNCTION INSERT-AT) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD REMOVE-AT ((SELF STRING-TO-INTEGER-HASH-TABLE) (KEY STRING)) :PUBLIC? TRUE)"
    (CL:FUNCTION REMOVE-AT) NULL)
   (DEFINE-FUNCTION-OBJECT "HASHMOD"
    "(DEFUN (HASHMOD INTEGER) ((CODE INTEGER) (SIZE INTEGER)) :DOCUMENTATION \"Map the hash code `code' onto a bucket index for a hash table
of `size' (i.e., onto the interval [0..size-1].  This is just like `rem' for
positive hash codes but also works for negative hash codes by mapping those
onto a positive number first.  Note, that the sign conversion mapping is not
equivalent to calling the `abs' function (it simply masks the sign bit for
speed) and therefore really only makes sense for hash codes.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:REM (CL:THE CL:FIXNUM (CL:LOGAND CODE *INTEGER-UNSIGNED-BITS-MASK*)) SIZE) :CPP \"(((unsigned int) code) % size)\" :JAVA \"((code & 0x7FFFFFFF) % size)\")))"
    (CL:FUNCTION HASHMOD) NULL))
  :VOID)

(CL:DEFUN HELP-STARTUP-PRIMAL5 ()
  (CL:PROGN
   (DEFINE-FUNCTION-OBJECT "ROTATE-HASH-CODE"
    "(DEFUN (ROTATE-HASH-CODE INTEGER) ((ARG INTEGER)) :DOCUMENTATION \"Rotate `arg' to the right by 1 position.  This means shift `arg' to the right
by one and feed in `arg's bit zero from the left.  In Lisp the result will stay
in positive FIXNUM range.  In C++ and Java this might return a negative
value which might be equal to NULL-INTEGER.  Important: to make this inlinable,
it must be called with an atom (i.e., constant or variable) as its argument.
This function is primarily useful for hashing sequences of items where the hash
code should take the sequential order of elements into account (e.g., lists).\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (CHOOSE (= (LOGAND ARG 1) 0) (UNSIGNED-SHIFT-RIGHT-BY-1 ARG) (LOGOR (SHIFT-RIGHT ARG 1) *INTEGER-MSB-MASK*))))"
    (CL:FUNCTION ROTATE-HASH-CODE) NULL)
   (DEFINE-FUNCTION-OBJECT "OBJECT-HASH-CODE"
    "(DEFUN (OBJECT-HASH-CODE INTEGER) ((SELF OBJECT)) :DOCUMENTATION \"Return a hash code for `self' (can be negative).  Two objects that are `eq?'
are guaranteed to generate the same hash code.  Two objects that are not `eq?'
do not necessarily generate different hash codes.  Similar to `hash-code' but
always hashes on the address of `self' even if it is a wrapper.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP \"(STELLA::%%OBJECT-HASH-CODE SELF)\" :CPP \"(size_t)self\" :JAVA \"self.hashCode()\")))"
    (CL:FUNCTION OBJECT-HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF OBJECT)) :DOCUMENTATION \"Return a hash code for `self' (can be negative).  Two objects that are `eql?'
are guaranteed to generate the same hash code.  Two objects that are not `eql?'
do not necessarily generate different hash codes.\" :PUBLIC? TRUE)"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-FUNCTION-OBJECT "SAFE-HASH-CODE"
    "(DEFUN (SAFE-HASH-CODE INTEGER) ((SELF OBJECT)) :DOCUMENTATION \"Return a hash code for `self'.  Just like `hash-code'
- which see, but also works for NULL.\" :PUBLIC? TRUE)"
    (CL:FUNCTION SAFE-HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF STANDARD-OBJECT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (OBJECT-HASH-CODE SELF)))"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF WRAPPER)) :PUBLIC? TRUE)"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF STRING-WRAPPER)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (HASH-CODE (WRAPPER-VALUE SELF))))"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF INTEGER-WRAPPER)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (HASH-CODE (WRAPPER-VALUE SELF))))"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF FLOAT-WRAPPER)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (HASH-CODE (WRAPPER-VALUE SELF))))"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF CHARACTER-WRAPPER)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (HASH-CODE (WRAPPER-VALUE SELF))))"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF BOOLEAN-WRAPPER)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (CHOOSE (WRAPPER-VALUE SELF) 7333705 1891526)))"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF STRING)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:SXHASH SELF) :JAVA \"self.hashCode()\" :CPP \"native_hash_string(self)\" :OTHERWISE (HASH-STRING SELF 0))))"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF INTEGER)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN SELF))"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF FLOAT)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:SXHASH SELF) :CPP \"(size_t)self\" :JAVA \"(int)(Double.doubleToLongBits(self)^(Double.doubleToLongBits(self)>>>32))\")))"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (HASH-CODE INTEGER) ((SELF CHARACTER)) :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (LOGXOR (AREF *HASH-BYTE-RANDOM-TABLE* (CHARACTER-CODE SELF)) 15119378)))"
    (CL:FUNCTION HASH-CODE) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (EQUAL-HASH-CODE INTEGER) ((SELF OBJECT)) :DOCUMENTATION \"Return a hash code for `self' (can be negative).  Two objects that are `equal?'
are guaranteed to generate the same hash code (provided, that writers of
`object-equal?' methods also implemented the appropriate `equal-hash-code'
method).  Two objects that are not `equal?'do not necessarily generate different
hash codes.\" :PUBLIC? TRUE)" (CL:FUNCTION EQUAL-HASH-CODE) NULL)
   (DEFINE-FUNCTION-OBJECT "SAFE-EQUAL-HASH-CODE"
    "(DEFUN (SAFE-EQUAL-HASH-CODE INTEGER) ((SELF OBJECT)) :DOCUMENTATION \"Return a hash code for `self'.  Just like `equal-hash-code'
- which see, but also works for NULL.  `equal-hash-code' methods that expect to
handle NULL components should use this function for recursive calls.\" :PUBLIC? TRUE)"
    (CL:FUNCTION SAFE-EQUAL-HASH-CODE) NULL)
   (DEFINE-FUNCTION-OBJECT "HASH-STRING"
    "(DEFUN (HASH-STRING INTEGER) ((STRING STRING) (SEEDCODE INTEGER)) :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE :DOCUMENTATION \"Generate a hash-code for `string' and return it.
Two strings that are equal but not eq will generate the same code.
The hash-code is based on `seedCode' which usually will be 0.  However,
`seedCode' can also be used to supply the result of a previous hash
operation to achieve hashing on sequences of strings without actually
having to concatenate them.\" (LET ((CODE SEEDCODE) (CURSOR (LENGTH STRING))) (IF (= CURSOR 0) (RETURN 4303803) (-- CURSOR)) (LOOP (SETQ CODE (LOGXOR CODE (AREF *HASH-BYTE-RANDOM-TABLE* (CHARACTER-CODE (NTH STRING CURSOR))))) (IF (= CURSOR 0) (BREAK) (-- CURSOR)) (SETQ CODE (ROTATE-HASH-CODE CODE))) (RETURN CODE)))"
    (CL:FUNCTION HASH-STRING) NULL)
   (DEFINE-FUNCTION-OBJECT "PICK-HASH-TABLE-SIZE-PRIME"
    "(DEFUN (PICK-HASH-TABLE-SIZE-PRIME INTEGER) ((MINSIZE INTEGER)) :DOCUMENTATION \"Return a hash table prime of at least `minSize'.\" :PUBLIC? TRUE)"
    (CL:FUNCTION PICK-HASH-TABLE-SIZE-PRIME) NULL)
   (DEFINE-METHOD-OBJECT "(DEFMETHOD INITIALIZE-VECTOR ((SELF VECTOR)))"
    (CL:FUNCTION INITIALIZE-VECTOR) NULL)
   (DEFINE-FUNCTION-OBJECT "RESIZE-VECTOR"
    "(DEFUN RESIZE-VECTOR ((SELF VECTOR) (SIZE INTEGER)) :DOCUMENTATION \"Change the size of `self' to `size'.  If `size' is smaller
than the current size of `self' the vector will be truncated.  Otherwise, 
the internal array of `self' will be grown to `size' and unused elements
will be initialized to NULL.\" :PUBLIC? TRUE)" (CL:FUNCTION RESIZE-VECTOR)
    NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NTH (LIKE (ANY-VALUE SELF))) ((SELF NATIVE-VECTOR) (POSITION INTEGER)) :DOCUMENTATION \"Return the element in `self' at `position'.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:AREF SELF POSITION) :CPP \"self[position]\" :JAVA \"self[position]\")))"
    (CL:FUNCTION NTH) NULL)
   (DEFINE-METHOD-OBJECT
    "(DEFMETHOD (NTH-SETTER (LIKE (ANY-VALUE SELF))) ((SELF NATIVE-VECTOR) (VALUE (LIKE (ANY-VALUE SELF))) (POSITION INTEGER)) :DOCUMENTATION \"Set the element in `self' at `position' to `value'.\" :PUBLIC? TRUE :GLOBALLY-INLINE? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:SETF (CL:AREF SELF POSITION) VALUE) :CPP \"self[position] = value\" :JAVA \"self[position] = value\")))"
    (CL:FUNCTION NTH-SETTER) NULL)
   (DEFINE-FUNCTION-OBJECT "UNMAKE" "(DEFUN UNMAKE ((SELF OBJECT)))"
    (CL:FUNCTION UNMAKE) NULL)
   (DEFINE-FUNCTION-OBJECT "PROBE-FILE?"
    "(DEFUN (PROBE-FILE? BOOLEAN) ((FILENAME FILE-NAME)) :DOCUMENTATION \"Return true if file `fileName' exists.  Note that this does
not necessarily mean that the file can also be read.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "FILE-WRITE-DATE"
    "(DEFUN (FILE-WRITE-DATE CALENDAR-DATE) ((FILENAME FILE-NAME)) :DOCUMENTATION \"Return the time at which file `fileName' was last modified or
NULL if that cannot be determined.\" :NATIVE? TRUE :PUBLIC? TRUE)" NULL NULL)
   (DEFINE-FUNCTION-OBJECT "FILE-LENGTH"
    "(DEFUN (FILE-LENGTH INTEGER) ((FILENAME FILE-NAME)) :DOCUMENTATION \"Return the length of file `fileName' in bytes or NULL if that
cannot be determined.  Note that this will currently overrun for files that
are longer than what can be represented by a STELLA integer.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "DELETE-FILE"
    "(DEFUN DELETE-FILE ((FILENAME FILE-NAME)) :DOCUMENTATION \"Delete the file `fileName'.\" :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "COPY-FILE"
    "(DEFUN COPY-FILE ((FROMFILE FILE-NAME) (TOFILE FILE-NAME)) :DOCUMENTATION \"Copy file `fromFile' to file `toFile', clobbering
any data already in `toFile'.\" :PUBLIC? TRUE)" (CL:FUNCTION COPY-FILE) NULL)
   (DEFINE-FUNCTION-OBJECT "LOGNOT"
    "(DEFUN (LOGNOT INTEGER) ((ARG INTEGER)) :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:LOGNOT ARG) :CPP \"(~ arg)\" :JAVA \"(~ arg)\")))"
    (CL:FUNCTION LOGNOT) NULL)
   (DEFINE-FUNCTION-OBJECT "LOGAND"
    "(DEFUN (LOGAND INTEGER) ((ARG1 INTEGER) (ARG2 INTEGER)) :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:LOGAND ARG1 ARG2) :CPP \"(arg1 & arg2)\" :JAVA \"(arg1 & arg2)\")))"
    (CL:FUNCTION LOGAND) NULL)
   (DEFINE-FUNCTION-OBJECT "LOGOR"
    "(DEFUN (LOGOR INTEGER) ((ARG1 INTEGER) (ARG2 INTEGER)) :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:LOGIOR ARG1 ARG2) :CPP \"(arg1 | arg2)\" :JAVA \"(arg1 | arg2)\")))"
    (CL:FUNCTION LOGOR) NULL)
   (DEFINE-FUNCTION-OBJECT "LOGXOR"
    "(DEFUN (LOGXOR INTEGER) ((ARG1 INTEGER) (ARG2 INTEGER)) :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:LOGXOR ARG1 ARG2) :CPP \"(arg1 ^ arg2)\" :JAVA \"(arg1 ^ arg2)\")))"
    (CL:FUNCTION LOGXOR) NULL)
   (DEFINE-FUNCTION-OBJECT "INTEGER-LENGTH"
    "(DEFUN (INTEGER-LENGTH INTEGER) ((ARG INTEGER)) :NATIVE? TRUE :PUBLIC? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "SHIFT-LEFT"
    "(DEFUN (SHIFT-LEFT INTEGER) ((ARG INTEGER) (COUNT INTEGER)) :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:ASH ARG COUNT) :CPP \"(arg << count)\" :JAVA \"(arg << count)\")))"
    (CL:FUNCTION SHIFT-LEFT) NULL)
   (DEFINE-FUNCTION-OBJECT "SHIFT-RIGHT"
    "(DEFUN (SHIFT-RIGHT INTEGER) ((ARG INTEGER) (COUNT INTEGER)) :DOCUMENTATION \"Shift `arg' to the right by `count' positions and
0-extend from the left if `arg' is positive or 1-extend if it is
negative.  This is an arithmetic shift that preserve the sign of `arg'
and is equivalent to dividing `arg' by 2** `count'.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:ASH ARG (CL:THE CL:FIXNUM (CL:- COUNT))) :CPP \"(arg >> count)\" :JAVA \"(arg >> count)\")))"
    (CL:FUNCTION SHIFT-RIGHT) NULL)
   (DEFINE-FUNCTION-OBJECT "UNSIGNED-SHIFT-RIGHT-BY-1"
    "(DEFUN (UNSIGNED-SHIFT-RIGHT-BY-1 INTEGER) ((ARG INTEGER)) :DOCUMENTATION \"Shift `arg' to the right by 1 position and 0-extend
from the left.  This does not preserve the sign of `arg' and shifts
the sign-bit just like a regular bit.  In Common-Lisp we can't do that
directly and need to do some extra masking.\" :GLOBALLY-INLINE? TRUE :PUBLIC? TRUE (RETURN (VERBATIM :COMMON-LISP (CL:LOGAND (CL:THE CL:FIXNUM (CL:ASH ARG -1)) *INTEGER-UNSIGNED-BITS-MASK*) :CPP \"((unsigned int)arg >> 1)\" :JAVA \"(arg >>> 1)\")))"
    (CL:FUNCTION UNSIGNED-SHIFT-RIGHT-BY-1) NULL)
   (DEFINE-FUNCTION-OBJECT "GENERATE-UUID"
    "(DEFUN (GENERATE-UUID STRING) ((UUID-TYPE KEYWORD)) :PUBLIC? TRUE :DOCUMENTATION \"Generates a UUID of the specified type.  Legal types are
a subset of the IETF RFC 4122 (see http://www.ietf.org/rfc/rfc4122.txt )
UUID types.  Currently supported are:
    :TYPE-4  :RANDOM       A type-4 (random) UUID.  These are synonyms.\")"
    (CL:FUNCTION GENERATE-UUID) NULL)
   (DEFINE-FUNCTION-OBJECT "GENERATE-RANDOM-UUID"
    "(DEFUN (GENERATE-RANDOM-UUID STRING) () :PUBLIC? TRUE :DOCUMENTATION \"Generates a random UUID (Type 4), according to the guidelines
of IETF RFC 4122 (see http://www.ietf.org/rfc/rfc4122.txt )

Take 16 random bytes (octets), put them all behind each other, for the description
the numbering starts with byte 1 (most significant, first) to byte 16 
   (least significant, last). Then put in the version and variant.
To put in the version, take the 7th byte and perform an and operation using 0x0f,
   followed by an or operation with 0x40. 
To put in the variant, take the 9th byte and perform an and operation using 0x3f,
   followed by an or operation with 0x80.
To make the string representation, take the hexadecimal presentation of bytes 1-4
   (without 0x in front of it) let them follow by a -, then take bytes 5 and 6, - 
bytes 7 and 8, - bytes 9 and 10, - then followed by bytes 11-16.\")"
    (CL:FUNCTION GENERATE-RANDOM-UUID) NULL)
   (DEFINE-FUNCTION-OBJECT "STELLIFY"
    "(DEFUN (STELLIFY OBJECT) ((SELF OBJECT)) :DOCUMENTATION \"Convert a Lisp object into a STELLA object.\" :PUBLIC? TRUE)"
    (CL:FUNCTION STELLIFY) NULL)
   (DEFINE-FUNCTION-OBJECT "STELLA-OBJECT?"
    "(DEFUN (STELLA-OBJECT? BOOLEAN) ((SELF OBJECT)) :DOCUMENTATION \"Return true if `self' is a member of the STELLA class `OBJECT'.\")"
    (CL:FUNCTION STELLA-OBJECT?) NULL)
   (DEFINE-FUNCTION-OBJECT "RUNNING-AS-LISP?"
    "(DEFUN (RUNNING-AS-LISP? BOOLEAN) () :DOCUMENTATION \"Return true if the executable code is a Common Lisp application.\")"
    (CL:FUNCTION RUNNING-AS-LISP?) NULL)
   (DEFINE-FUNCTION-OBJECT "RUNNING-IN-LANGUAGE"
    "(DEFUN (RUNNING-IN-LANGUAGE KEYWORD) () :DOCUMENTATION \"Returns the keyword for the language the current implementation is running in.\")"
    (CL:FUNCTION RUNNING-IN-LANGUAGE) NULL)
   (DEFINE-FUNCTION-OBJECT "RUNNING-SYSTEM-INFORMATION"
    "(DEFUN (RUNNING-SYSTEM-INFORMATION STRING) () :DOCUMENTATION \"Returns an information string about the current running system environment.\")"
    (CL:FUNCTION RUNNING-SYSTEM-INFORMATION) NULL)
   (DEFINE-FUNCTION-OBJECT "GET-TICKTOCK"
    "(DEFUN (GET-TICKTOCK TICKTOCK) () :DOCUMENTATION \"Return the current CPU time.  If the current OS/Language
combination does not support measuring of CPU time, return real time instead.
Use `ticktock-difference' to measure the time difference between values
returned by this function.  This is an attempt to provide some platform
independent support to measure (at least approximately) consumed CPU time.\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "TICKTOCK-DIFFERENCE"
    "(DEFUN (TICKTOCK-DIFFERENCE FLOAT) ((T1 TICKTOCK) (T2 TICKTOCK)) :DOCUMENTATION \"The difference in two TICKTOCK time values in seconds where
`t1' is the earlier time.  The resolution is implementation dependent but will
normally be some fractional value of a second.\" :PUBLIC? TRUE :NATIVE? TRUE)"
    NULL NULL)
   (DEFINE-FUNCTION-OBJECT "TICKTOCK-RESOLUTION"
    "(DEFUN (TICKTOCK-RESOLUTION FLOAT) () :DOCUMENTATION \"The minimum theoretically detectable resolution of the
difference in two TICKTOCK time values in seconds.  This
resolution is implementation dependent.  It may also not
be realizable in practice, since the timing grain size may
be larger than this resolution.\" :PUBLIC? TRUE :NATIVE? TRUE)" NULL NULL)
   (DEFINE-FUNCTION-OBJECT "SLEEP"
    "(DEFUN SLEEP ((SECONDS FLOAT)) :DOCUMENTATION \"The program will sleep for the indicated number of seconds.
Fractional values are allowed, but the results are implementation dependent:
Common Lisp uses the fractions natively, Java with a resolution of 0.001,
and C++ can only use integral values.\")" (CL:FUNCTION SLEEP) NULL)
   (DEFINE-FUNCTION-OBJECT "EXCEPTION-MESSAGE"
    "(DEFUN (EXCEPTION-MESSAGE STRING) ((E NATIVE-EXCEPTION)) :PUBLIC? TRUE :DOCUMENTATION \"Accesses the error message of the exception `e'.\")"
    (CL:FUNCTION EXCEPTION-MESSAGE) NULL)
   (DEFINE-FUNCTION-OBJECT "PRINT-EXCEPTION-CONTEXT"
    "(DEFUN PRINT-EXCEPTION-CONTEXT ((E NATIVE-EXCEPTION) (STREAM OUTPUT-STREAM)) :PUBLIC? TRUE :DOCUMENTATION \"Prints a system dependent information about the context of the specified
exception.  For example, in Java it prints a stack trace.  In Lisp, it is vendor dependent.\")"
    (CL:FUNCTION PRINT-EXCEPTION-CONTEXT) NULL)
   (DEFINE-FUNCTION-OBJECT "MAKE-PROCESS-LOCK"
    "(DEFUN (MAKE-PROCESS-LOCK PROCESS-LOCK-OBJECT) () :PUBLIC? TRUE)"
    (CL:FUNCTION MAKE-PROCESS-LOCK) NULL)
   (DEFINE-FUNCTION-OBJECT "STARTUP-PRIMAL"
    "(DEFUN STARTUP-PRIMAL () :PUBLIC? TRUE)" (CL:FUNCTION STARTUP-PRIMAL)
    NULL)
   (CL:LET* ((FUNCTION (LOOKUP-FUNCTION SYM-PRIMAL-STELLA-STARTUP-PRIMAL)))
    (SET-DYNAMIC-SLOT-VALUE (%DYNAMIC-SLOTS FUNCTION)
     SYM-PRIMAL-STELLA-METHOD-STARTUP-CLASSNAME (WRAP-STRING "_StartupPrimal")
     NULL-STRING-WRAPPER)))
  :VOID)

(CL:DEFUN STARTUP-PRIMAL ()
  (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 0)
   (CL:SETQ *HASH-BYTE-RANDOM-TABLE* (CL:MAKE-ARRAY 256))
   (CL:LET* ((I NULL-INTEGER) (ITER-008 0) (UPPER-BOUND-009 255))
    (CL:DECLARE (CL:TYPE CL:FIXNUM I ITER-008 UPPER-BOUND-009))
    (CL:LOOP WHILE (CL:<= ITER-008 UPPER-BOUND-009) DO (CL:SETQ I ITER-008)
     (CL:SETF (CL:AREF *HASH-BYTE-RANDOM-TABLE* I) 0)
     (CL:SETQ ITER-008 (CL:1+ ITER-008))))
   (CL:LET*
    ((BIT NULL-INTEGER) (ITER-010 0)
     (UPPER-BOUND-011 #.(cl:1- (cl:integer-length cl:most-positive-fixnum)))
     (UNBOUNDED?-012 (NULL? UPPER-BOUND-011)))
    (CL:DECLARE (CL:TYPE CL:FIXNUM BIT ITER-010 UPPER-BOUND-011))
    (CL:LOOP WHILE (CL:OR UNBOUNDED?-012 (CL:<= ITER-010 UPPER-BOUND-011)) DO
     (CL:SETQ BIT ITER-010)
     (CL:LET* ((I NULL-INTEGER) (ITER-013 0) (UPPER-BOUND-014 255))
      (CL:DECLARE (CL:TYPE CL:FIXNUM I ITER-013 UPPER-BOUND-014))
      (CL:LOOP WHILE (CL:<= ITER-013 UPPER-BOUND-014) DO (CL:SETQ I ITER-013)
       (CL:SETF (CL:AREF *HASH-BYTE-RANDOM-TABLE* I)
        (CL:THE CL:FIXNUM
         (CL:LOGIOR (CL:THE CL:FIXNUM (CL:AREF *HASH-BYTE-RANDOM-TABLE* I))
          (CL:THE CL:FIXNUM (CL:ASH (CL:THE CL:FIXNUM (RANDOM 2)) BIT)))))
       (CL:SETQ ITER-013 (CL:1+ ITER-013))))
     (CL:SETQ ITER-010 (CL:1+ ITER-010))))
   (CL:SETQ *HASH-TABLE-SIZE-PRIME-STRINGS*
    (VECTOR (WRAP-STRING "29") (WRAP-STRING "53") (WRAP-STRING "97")
     (WRAP-STRING "193") (WRAP-STRING "389") (WRAP-STRING "769")
     (WRAP-STRING "1543") (WRAP-STRING "3079") (WRAP-STRING "6151")
     (WRAP-STRING "12289") (WRAP-STRING "24593") (WRAP-STRING "49157")
     (WRAP-STRING "98317") (WRAP-STRING "196613") (WRAP-STRING "393241")
     (WRAP-STRING "786433") (WRAP-STRING "1572869") (WRAP-STRING "3145739")
     (WRAP-STRING "6291469") (WRAP-STRING "12582917") (WRAP-STRING "25165843")
     (WRAP-STRING "50331653") (WRAP-STRING "100663319")
     (WRAP-STRING "201326611") (WRAP-STRING "402653189")
     (WRAP-STRING "805306457") (WRAP-STRING "1610612741")))
   (CL:SETQ *HASH-TABLE-SIZE-PRIMES* (cl:apply #'vector 
                 (cl:loop for index below (length *hash-table-size-prime-strings*)
                          as i = (cl:parse-integer
                                    (unwrap-string (nth *hash-table-size-prime-strings*
                                                        index)))
                          when (cl:typep i 'CL:FIXNUM)
                          collect (wrap-integer i)))))
  (CL:LET* ((*MODULE* *STELLA-MODULE*) (*CONTEXT* *MODULE*))
   (CL:DECLARE (CL:SPECIAL *MODULE* *CONTEXT*))
   (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 2) (HELP-STARTUP-PRIMAL1))
   (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 4)
    (CL:SETQ RECIPROCAL-NL10
     (CL:/ 1.0d0 (CL:THE CL:DOUBLE-FLOAT (CL:LOG 10.0d0)))))
   (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 6) (FINALIZE-CLASSES))
   (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 7) (HELP-STARTUP-PRIMAL2)
    (HELP-STARTUP-PRIMAL3) (HELP-STARTUP-PRIMAL4) (HELP-STARTUP-PRIMAL5))
   (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 8) (FINALIZE-SLOTS)
    (CLEANUP-UNFINALIZED-CLASSES))
   (CL:WHEN (CURRENT-STARTUP-TIME-PHASE? 9)
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT PI FLOAT (VERBATIM :COMMON-LISP \"(cl:float CL:PI 0.0d0)\" :CPP \"3.141592653589793\" :JAVA \"java.lang.Math.PI\") :PUBLIC? TRUE :DOCUMENTATION \"A float approximation of the mathematical constant pi.\")")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(defconstant NULL UNKNOWN NULL
       :public? TRUE
       :documentation
       \"Generic undefined value for any STELLA data type.  The STELLA
translator substitutes specific NULL-values appropriate for a particular data
type.  For example, NULL-INTEGER represents the undefined INTEGER value.\")")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT NULL-INTEGER INTEGER (VERBATIM :COMMON-LISP CL:MOST-NEGATIVE-FIXNUM :CPP \"1 << (sizeof (int) / sizeof (char) * 8 - 1)\" :JAVA \"Integer.MIN_VALUE\") :PUBLIC? TRUE)")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT NULL-SHORT-INTEGER SHORT-INTEGER (VERBATIM :COMMON-LISP CL:MOST-NEGATIVE-FIXNUM :CPP \"1 << (sizeof (short int) / sizeof (char) * 8 - 1)\" :JAVA \"Short.MIN_VALUE\") :PUBLIC? TRUE)")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT NULL-LONG-INTEGER LONG-INTEGER (VERBATIM :COMMON-LISP CL:MOST-NEGATIVE-FIXNUM :CPP \"1 << (sizeof (long int) / sizeof (char) * 8 - 1)\" :JAVA \"Long.MIN_VALUE\") :PUBLIC? TRUE)")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT NULL-UNSIGNED-SHORT-INTEGER UNSIGNED-SHORT-INTEGER (VERBATIM :COMMON-LISP CL:MOST-NEGATIVE-FIXNUM :CPP \"(unsigned short int) -1\" :JAVA \"Short.MIN_VALUE\") :PUBLIC? TRUE)")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT NULL-UNSIGNED-LONG-INTEGER UNSIGNED-LONG-INTEGER (VERBATIM :COMMON-LISP CL:MOST-NEGATIVE-FIXNUM :CPP \"(unsigned long int) -1\" :JAVA \"Long.MIN_VALUE\") :PUBLIC? TRUE)")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT NULL-FLOAT FLOAT (VERBATIM :COMMON-LISP CL:MOST-NEGATIVE-DOUBLE-FLOAT :CPP \"-HUGE_VAL /* IEEE infinity, defined in <math.h> */\" :JAVA \"Double.NEGATIVE_INFINITY; /* IEEE Infinity */\") :PUBLIC? TRUE)")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT NULL-SINGLE-FLOAT SINGLE-FLOAT (VERBATIM :COMMON-LISP CL:MOST-NEGATIVE-SINGLE-FLOAT :CPP \"-HUGE_VAL /* IEEE infinity, defined in <math.h> */\" :JAVA \"Float.NEGATIVE_INFINITY; /* IEEE Infinity */\") :PUBLIC? TRUE)")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT NULL-DOUBLE-FLOAT DOUBLE-FLOAT (VERBATIM :COMMON-LISP CL:MOST-NEGATIVE-DOUBLE-FLOAT :CPP \"-HUGE_VAL /* IEEE infinity, defined in <math.h> */\" :JAVA \"Double.NEGATIVE_INFINITY; /* IEEE Infinity */\") :PUBLIC? TRUE)")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT NULL-CHARACTER CHARACTER (VERBATIM :COMMON-LISP (CL:CODE-CHAR 0) :CPP \"'\\\\0'\" :JAVA \"Character.MIN_VALUE\") :PUBLIC? TRUE)")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT NULL-BYTE BYTE (VERBATIM :COMMON-LISP \"255\" :CPP \"255\" :JAVA \"-128\") :PUBLIC? TRUE)")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT NULL-OCTET OCTET (VERBATIM :COMMON-LISP \"255\" :CPP \"255\" :JAVA \"-128\") :PUBLIC? TRUE)")
    (SEED-RANDOM-NUMBER-GENERATOR)
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT RECIPROCAL-NL10 FLOAT (/ 1.0 (LOG 10.0)) :DOCUMENTATION \"1 / (log 10) Reciprocal of the Log base e of 10.
Used for log 10 conversions.\")")
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-FLOOR KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-ROUND KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-FMOD KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-RANDOM KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-SQRT KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-COS KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-SIN KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-TAN KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-ACOS KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-ASIN KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-ATAN KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-ATAN2 KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-EXP KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-LOG KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-MIN KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-MAX KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFSPECIAL *TRANSIENTOBJECTS?* BOOLEAN FALSE :PUBLIC? TRUE)")
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-HASH-CODE KWD-PRIMAL-JAVA
     KWD-PRIMAL-FUNCTION)
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFGLOBAL *HASH-BYTE-RANDOM-TABLE* (ARRAY (256) OF INTEGER) NULL :DOCUMENTATION \"A table of 256 N-bit random numbers that can be used to
hash sequences of bytes.  Each bit-column in the table has an approximately
even number of 0's and 1's.\")")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT *INTEGER-MSB-MASK* INTEGER (VERBATIM :COMMON-LISP \"#.(CL:ash 1 (CL:1- (CL:integer-length CL:most-positive-fixnum)))\" :CPP \"1 << (sizeof (int) / sizeof (char) * 8 - 1)\" :JAVA \"0x80000000\") :DOCUMENTATION \"The most significant bit of a regular integer (FIXNUM
in Common-Lisp).  In C++ and Java this corresponds to the sign bit, in
Lisp this corresponds to the left-most bit of `CL:most-positive-fixnum'.\")")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFCONSTANT *INTEGER-UNSIGNED-BITS-MASK* INTEGER (VERBATIM :COMMON-LISP (CL:LOGIOR (CL:1- *INTEGER-MSB-MASK*) *INTEGER-MSB-MASK*) :OTHERWISE (LOGNOT *INTEGER-MSB-MASK*)) :DOCUMENTATION \"Mask that covers all the unsigned bits of an integer.\")")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFGLOBAL *HASH-TABLE-SIZE-PRIME-STRINGS* (VECTOR OF STRING-WRAPPER) NULL :DOCUMENTATION \"List of prime numbers approximately growing by a factor of 2
that are suitable to be used as hash table sizes.  This is in string
format to enable processing by Lisps with different fixnum sizes.\" :PUBLIC? TRUE)")
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFGLOBAL *HASH-TABLE-SIZE-PRIMES* (VECTOR OF INTEGER-WRAPPER) NULL :DOCUMENTATION \"List of prime numbers approximately growing by a factor of 2
that are suitable to be used as hash table sizes.\" :PUBLIC? TRUE)")
    (REGISTER-NATIVE-NAME SYM-PRIMAL-STELLA-SLEEP KWD-PRIMAL-CPP
     KWD-PRIMAL-FUNCTION)
    (DEFINE-STELLA-GLOBAL-VARIABLE-FROM-STRINGIFIED-SOURCE
     "(DEFGLOBAL *BOOTSTRAP-LOCK* PROCESS-LOCK-OBJECT (VERBATIM :COMMON-LISP \"(%make-process-lock)\" :JAVA \"new java.lang.Object()\" :CPP \"NULL\") :PUBLIC? TRUE :DOCUMENTATION \"Process lock object for bootstrap use.\")")))
  :VOID)