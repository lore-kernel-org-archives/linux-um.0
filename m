Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HllRx-0005xN-RA for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 05:39:21 -0700
Received: from mu-out-0910.google.com ([209.85.134.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HllRx-0003Wf-Cj
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 05:39:21 -0700
Received: by mu-out-0910.google.com with SMTP id i2so117181mue
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 09 May 2007 05:39:20 -0700 (PDT)
Message-ID: <c28964800705090539x40642034u274711deba057a0f@mail.gmail.com>
Date: Wed, 9 May 2007 18:09:19 +0530
From: "Lakshminarasimhan Naveenam" <lsimhan05@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] Slow uml sessions
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0727944323=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============0727944323==
Content-Type: multipart/alternative; 
	boundary="----=_Part_90076_2036320.1178714359842"

------=_Part_90076_2036320.1178714359842
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
     When I run 2 uml sessions using netkit , kernel version is 2.6.18.5,
the uml sessions become very slow. On the command prompt I keep getting this
message:
BUG: soft lockup detected on CPU#0!

The var/log/messages has a lot of stack trace dump of the following type:

                      dump_stack+0x1b/0x1f
 [<0808a61a>] softlockup_tick+0x7a/0x81
[<08079318>] run_local_timers+0x12/0x14
[<08079150>] update_process_times+0x3b/0x64
[<0805933d>] timer_handler+0x2c/0x4f
[<08069c1f>] user_signal+0x4b/0x5c
[<08069439>] userspace+0x214/0x240
[<0805aa31>] fork_handler+0x95/0x9d
[<b7fcd420>] 0xb7fcd420

Anybody can help me understand whats going on?

Thanks,
simha.

------=_Part_90076_2036320.1178714359842
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>
&nbsp;&nbsp;&nbsp;&nbsp; When I run 2 uml sessions using netkit ,
kernel version is <a href="http://2.6.18.5">2.6.18.5</a>, the uml sessions become very slow. On the
command prompt I keep getting this message:<br>
BUG: soft lockup detected on CPU#0!<br>
<br>
The var/log/messages has a lot of stack trace dump of the following type:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
dump_stack+0x1b/0x1f<br>
&nbsp;[&lt;0808a61a&gt;] softlockup_tick+0x7a/0x81<br>
[&lt;08079318&gt;] run_local_timers+0x12/0x14<br>
[&lt;08079150&gt;] update_process_times+0x3b/0x64<br>
[&lt;0805933d&gt;] timer_handler+0x2c/0x4f<br>
[&lt;08069c1f&gt;] user_signal+0x4b/0x5c<br>
[&lt;08069439&gt;] userspace+0x214/0x240<br>
[&lt;0805aa31&gt;] fork_handler+0x95/0x9d<br>
[&lt;b7fcd420&gt;] 0xb7fcd420<br>
<br>
Anybody can help me understand whats going on?<br>
<br>
Thanks,<br>
simha.<br>
<br>
<br>

------=_Part_90076_2036320.1178714359842--


--===============0727944323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0727944323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0727944323==--

