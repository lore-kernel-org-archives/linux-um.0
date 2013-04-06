Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <terry.shoes@gmail.com>) id 1UOYiT-0006R7-MF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Apr 2013 19:23:57 +0000
Received: from mail-qe0-f41.google.com ([209.85.128.41])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UOYiP-0002QK-C3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Apr 2013 19:23:57 +0000
Received: by mail-qe0-f41.google.com with SMTP id b10so1289590qen.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 06 Apr 2013 12:23:47 -0700 (PDT)
MIME-Version: 1.0
From: Terry Hsu <terry.shoes@gmail.com>
Date: Sat, 6 Apr 2013 15:23:07 -0400
Message-ID: <CAER6CkdnaFQshNMPkQVdXjB9Z3MyoMTg+grcPwwW=yGVjmhEZg@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0081724214555088353=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Endless page fault for the same miss address in my UML
To: user-mode-linux-devel@lists.sourceforge.net

--===============0081724214555088353==
Content-Type: multipart/alternative; boundary=20cf3074b44a94bc7b04d9b62444

--20cf3074b44a94bc7b04d9b62444
Content-Type: text/plain; charset=ISO-8859-1

Hello guys,

Is there any available resource that explains how user-mode-linux maps the
pages of a task in UML to the host kernel?

In my UML, I modified a task's page table when forking it. Then I ran into
a situation where the page fault happens over and over again for the same
address in the forked task. I use gdb debugger and find out that when the
page fault happens for the first time, the kernel calls do_wp_page() to
fault in the page and marks the page present. This should prevent the next
page fault for the same address from happening again. I checked the PTE in
UML, they are marked as present so is it possible that the page is not
being allocated properly on the host kernel so that the page fault keeps
happening for the same address even though UML thinks the page is present.

Any suggestions?

Thank!

--20cf3074b44a94bc7b04d9b62444
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello guys,<div><br></div><div>Is there any available reso=
urce that explains how user-mode-linux maps the pages of a task in UML to t=
he host kernel?</div><div><br></div><div>In my UML, I modified a task&#39;s=
 page table when forking it. Then I ran into a situation where the page fau=
lt happens over and over again for the same address in the forked task. I u=
se gdb debugger and find out that when the page fault happens for the first=
 time, the kernel calls do_wp_page() to fault in the page and marks the pag=
e present. This should prevent the next page fault for the same address fro=
m happening again. I checked the PTE in UML, they are marked as present so =
is it possible that the page is not being allocated properly on the host ke=
rnel so that the page fault keeps happening for the same address even thoug=
h UML thinks the page is present.=A0</div>

<div><br></div><div style>Any suggestions?</div>
<div><br></div><div>Thank!</div><div><br></div><div>=A0</div></div>

--20cf3074b44a94bc7b04d9b62444--


--===============0081724214555088353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
--===============0081724214555088353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0081724214555088353==--


