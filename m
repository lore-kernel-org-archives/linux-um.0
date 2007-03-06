Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOj90-0004Pv-V3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 15:32:35 -0800
Received: from wr-out-0506.google.com ([64.233.184.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOj90-00027y-Js
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 15:32:34 -0800
Received: by wr-out-0506.google.com with SMTP id 68so2585828wri
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 06 Mar 2007 15:32:33 -0800 (PST)
Message-ID: <3aab51dc0703061532g4b5e763co8927b5abeabcc2d@mail.gmail.com>
Date: Tue, 6 Mar 2007 16:32:32 -0700
From: "Haifeng He" <hehaifeng@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] Question about system call trap in UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1272095049=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1272095049==
Content-Type: multipart/alternative; 
	boundary="----=_Part_173165_19643609.1173223952991"

------=_Part_173165_19643609.1173223952991
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am beginner of UML. I have a question about how the system call
trap happens in UML in skas0 mode. Suppose a user application
within UML initialed a system call. How does UML track the
system call and is the host OS the one to actually handle the system
call?

Particularly, I found a file: arch/um/sys-i386/stub.S. Is the file used
for handling syscalls in user application? Can somebody explain the
process to me?

Thank you

Haifeng

------=_Part_173165_19643609.1173223952991
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I am beginner of UML. I have a question about how the system call</div>
<div>trap happens in UML in skas0 mode. Suppose a user application</div>
<div>within UML&nbsp;initialed a system call. How does UML&nbsp;track the </div>
<div>system call and&nbsp;is the host OS the one to actually handle the system</div>
<div>call? </div>
<div>&nbsp;</div>
<div>Particularly, I found a file: arch/um/sys-i386/stub.S. Is the file used</div>
<div>for handling syscalls in user application? Can somebody explain the</div>
<div>process&nbsp;to me?</div>
<div>&nbsp;</div>
<div>Thank you</div>
<div>&nbsp;</div>
<div>Haifeng</div>

------=_Part_173165_19643609.1173223952991--


--===============1272095049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1272095049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1272095049==--
