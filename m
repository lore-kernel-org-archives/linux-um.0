Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HcE7G-0002Cu-MB for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Apr 2007 22:14:34 -0700
Received: from an-out-0708.google.com ([209.85.132.245])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HcE7G-0004QM-AN
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Apr 2007 22:14:34 -0700
Received: by an-out-0708.google.com with SMTP id d40so1971535and
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 12 Apr 2007 22:14:33 -0700 (PDT)
Message-ID: <3aab51dc0704122214g6be916fdm148a7ff52d4e369c@mail.gmail.com>
Date: Thu, 12 Apr 2007 22:14:32 -0700
From: "Haifeng He" <hehaifeng@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] Strange segmentation fault
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0761393258=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============0761393258==
Content-Type: multipart/alternative; 
	boundary="----=_Part_747_11906119.1176441272962"

------=_Part_747_11906119.1176441272962
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I met a program error when I tried to modify UML kernel. What I did was:
 1. added a variable "a" in struct task_struct.
 2. I wrote a function that will update the value of "a" in task struct
"current", i.e.,
  something like:
   foo () {
     current->a = xx.
   }
 3. foo is called at many places.

Now, when I run the kernel, it goes to kernal panic in "start_userspace",
and it
shows error message
"panic - not syncing: start_userspace : expected SIGSTOP, got status = 2943"

I checked the value of status. It means a segv signal. My guess is
foo () was probably called in user address space and since it caused segv
because
it tried to access UML kernel address space. My question is, if it is
possible
such thing happened, i.e., some code in UML kernel may be executed in user
address
space? If not, what could be the cause for such error? The strange thing is,

if I just read value of "a" from "current", kernel runs fine.

Thanks

Haifeng

------=_Part_747_11906119.1176441272962
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I met a program error when I tried to modify UML kernel. What I did was:</div>
<div>&nbsp;1. added a variable &quot;a&quot; in struct task_struct.</div>
<div>&nbsp;2. I wrote a function that will update the value of &quot;a&quot; in task struct &quot;current&quot;, i.e.,</div>
<div>&nbsp; something like:</div>
<div>&nbsp;&nbsp; foo () {</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; current-&gt;a = xx.</div>
<div>&nbsp;&nbsp; }</div>
<div>&nbsp;3. foo is called at many places.</div>
<div>&nbsp;</div>
<div>Now, when&nbsp;I run the kernel, it goes to kernal panic in &quot;start_userspace&quot;, and it </div>
<div>shows error message </div>
<div>&quot;panic - not syncing: start_userspace : expected SIGSTOP, got status = 2943&quot;</div>
<div>&nbsp;</div>
<div>I checked the value of status. It means a segv signal. My guess is </div>
<div>foo () was probably called in user address space and since it caused segv because</div>
<div>it tried to access UML kernel address space. My question is, if it is possible </div>
<div>such thing happened, i.e., some code in UML kernel may be executed in user address</div>
<div>space? If not, what could be the cause for such error? The strange thing is, </div>
<div>if I just read value of &quot;a&quot; from &quot;current&quot;, kernel runs fine.</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>&nbsp;</div>
<div>Haifeng</div>

------=_Part_747_11906119.1176441272962--


--===============0761393258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0761393258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0761393258==--

