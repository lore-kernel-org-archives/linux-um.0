Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BnOxU-0002qX-HQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jul 2004 14:49:04 -0700
Received: from e6.ny.us.ibm.com ([32.97.182.106])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BnOxT-00037B-Kz
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jul 2004 14:49:03 -0700
Received: from northrelay04.pok.ibm.com (northrelay04.pok.ibm.com
	[9.56.224.206])
	by e6.ny.us.ibm.com (8.12.10/8.12.9) with ESMTP id i6LLmZnt666158
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Jul 2004 17:48:35 -0400
Received: from d01ml604.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by northrelay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	i6LLnXZu125636 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Jul 2004 17:49:33 -0400
MIME-Version: 1.0
Message-ID: <OF61F78B76.DD6FCAF5-ON85256ED8.00777608-04256ED8.007798C0@us.ibm.com>
From: Himanshu Raj <hraj@us.ibm.com>
Content-Type: multipart/alternative;
	boundary="=_alternative 007798B804256ED8_="
Subject: [uml-devel] make mrproper leaves some files around ....
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 21 Jul 2004 17:48:34 -0400
To: user-mode-linux-devel@lists.sourceforge.net


This is a multipart message in MIME format.
--=_alternative 007798B804256ED8_=
Content-Type: text/plain; charset="US-ASCII"

Hi Folks,

When I do
make mrproper ARCH=um

executables mk_task and mk_conatant don't go away from arch/um/util. I 
tried putting the following lines in the arch/um/util/Makefile:

clean : 
        $(RM) -f $(host-progs)

mrproper : clean


But that doesn't work. I tried finding where I can add a target for CLEAN, 
but I don't understand the new kbuild process really well. Can anyone
take a shot at this?

Thanks,
Himanshu Raj
IBM T.J. Watson Research Center
Yorktown Heights, NY 
--=_alternative 007798B804256ED8_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi Folks,</font>
<br>
<br><font size=2 face="sans-serif">When I do</font>
<br><font size=2 face="sans-serif">make mrproper ARCH=um</font>
<br>
<br><font size=2 face="sans-serif">executables mk_task and mk_conatant
don't go away from arch/um/util. I tried putting the following lines in
the arch/um/util/Makefile:</font>
<br>
<br><font size=2 face="sans-serif">clean : </font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; $(RM)
-f $(host-progs)</font>
<br>
<br><font size=2 face="sans-serif">mrproper : clean</font>
<br>
<br>
<br><font size=2 face="sans-serif">But that doesn't work. I tried finding
where I can add a target for CLEAN, but I don't understand the new kbuild
process really well. Can anyone</font>
<br><font size=2 face="sans-serif">take a shot at this?</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br><font size=2 face="sans-serif">Himanshu Raj<br>
IBM T.J. Watson Research Center<br>
Yorktown Heights, NY </font>
--=_alternative 007798B804256ED8_=--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
