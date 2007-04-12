Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hbolj-0004Tm-F9 for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 19:10:46 -0700
Received: from nz-out-0506.google.com ([64.233.162.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hbolh-0002K7-NO
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 19:10:39 -0700
Received: by nz-out-0506.google.com with SMTP id i11so758640nzi
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Wed, 11 Apr 2007 19:10:37 -0700 (PDT)
Message-ID: <3aab51dc0704111910p54a3066aref3663180003d671@mail.gmail.com>
Date: Wed, 11 Apr 2007 19:10:36 -0700
From: "Haifeng He" <hehaifeng@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] Question about trap handling in UML kernel
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0870155743=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: User-mode-linux-devel@lists.sourceforge.net

--===============0870155743==
Content-Type: multipart/alternative; 
	boundary="----=_Part_21425_27885195.1176343836664"

------=_Part_21425_27885195.1176343836664
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, All

I have a question about trap handling in UML kernel, particularly in the
skas0 mode.
My understanding is that, UML will fork a kernel thread for each user
process and
this thread will go to a loop (in userspace()) and wait for signal from user
process using
ptrace. If a signal occurs, it will call the signal handler to handle the
interrupt.
Is it correct?

My second question is, how many kernel threads are there in skas0 mode or I
should
ask how many different kinds of kernel threads will be created? Is there any
kernel thread
in UML other than those created for user process?

My last question is, given a kernel thread, if it is possible that the
execution of a thread will
be interrupted by others other than by scheduler?

Thank you

Haifeng

------=_Part_21425_27885195.1176343836664
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi, All</div>
<div>&nbsp;</div>
<div>I have a question about trap handling in UML kernel, particularly in the skas0 mode. </div>
<div>My understanding is that, UML will fork a kernel thread for each user process and </div>
<div>this thread will go to a loop (in userspace()) and wait for signal from user process using</div>
<div>ptrace. If a signal occurs, it will call the signal handler to handle the interrupt. </div>
<div>Is it correct?</div>
<div>&nbsp;</div>
<div>My second question is, how many kernel threads are there in skas0 mode or I should</div>
<div>ask how many different kinds of kernel threads will be created? Is there any kernel thread</div>
<div>in UML other than those created for user process?</div>
<div>&nbsp;</div>
<div>My last question is, given a kernel thread, if it is possible that the execution of a thread will </div>
<div>be interrupted by others other than by scheduler?</div>
<div>&nbsp;</div>
<div>Thank you</div>
<div>&nbsp;</div>
<div>Haifeng</div>
<div>&nbsp;</div>

------=_Part_21425_27885195.1176343836664--


--===============0870155743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0870155743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0870155743==--

