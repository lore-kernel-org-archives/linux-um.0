Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KEJdf-0000iN-AP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jul 2008 00:53:59 -0700
Received: from smtp-out.google.com ([216.239.33.17])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KEJdd-0006Bm-Oj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jul 2008 00:53:59 -0700
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id m637rmJn016811
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 3 Jul 2008 08:53:48 +0100
Received: from rv-out-0506.google.com (rvbk40.prod.google.com [10.140.87.40])
	by zps76.corp.google.com with ESMTP id m637qi3s011582
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 3 Jul 2008 00:53:47 -0700
Received: by rv-out-0506.google.com with SMTP id k40so885741rvb.31
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 03 Jul 2008 00:53:47 -0700 (PDT)
Message-ID: <5df78e1d0807030053x8a9bfabo582ea78e74b2c65b@mail.gmail.com>
Date: Thu, 3 Jul 2008 00:53:46 -0700
From: "Jiaying Zhang" <jiayingz@google.com>
MIME-Version: 1.0
Subject: [SPAM] [uml-devel] 2.6.25 uml kernel crashes when it calls down() on a
	semaphore with zero counter
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0852991849=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============0852991849==
Content-Type: multipart/alternative; 
	boundary="----=_Part_14135_22042807.1215071626838"

------=_Part_14135_22042807.1215071626838
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I found since 2.6.25 kernels, uml crashes when it calls down() on a
semaphore with
zero counter. Here is some example code.

static struct semaphore test_sem;
static int testfunc(NULL)
{
        interruptible_sleep_on_timeout(&sleep_queue, 5 * HZ); // after some
short period
        up(&test_sem); // up the semaphore
}

static int parent_func(unsigned argc, char **argv)
{
        sema_init(&test_sem, 0); // init semaphore with zero counter
        kernel_thread((void *)testfunc, target, CLONE_FILES); // create a
thread that will up the semaphore
        down_interruptible(&test_sem); // SHOULD wait here until testfunc up
the semaphore
}

Our kernel module has used this kind of code to synchronize different kernel
threads.
It runs fine on real machine and old uml kernels, but crashes on
2.6.25.4uml. I tried the
latest 2.6.25.9 kernel, and still saw the same problem. It seems to have
something to
do with uml's signal handling. Does anyone know what changes in 2.6.25 uml
code that
may cause the problem? Thanks a lot!

Jiaying

------=_Part_14135_22042807.1215071626838
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I found since 2.6.25 kernels, uml crashes when it calls down() on a semaphore with<br>zero counter. Here is some example code.<br><br>static struct semaphore test_sem;<br>
static int testfunc(NULL)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interruptible_sleep_on_timeout(&amp;sleep_queue, 5 * HZ); // after some short period<br><div id="mb_4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up(&amp;test_sem); // up the semaphore<br>}<br><br>static int parent_func(unsigned argc, char **argv)<br>

{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sema_init(&amp;test_sem, 0); // init semaphore with zero counter<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel_thread((void *)testfunc, target, CLONE_FILES); // create a thread that will up the semaphore<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_interruptible(&amp;test_sem); // SHOULD wait here until testfunc up the semaphore<br>

}<br><br>Our kernel module has used this kind of code to synchronize different kernel threads.<br>It runs fine on real machine and old uml kernels, but crashes on <a href="http://2.6.25.4/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">2.6.25.4</a> uml. I tried the<br>

latest <a href="http://2.6.25.9/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">2.6.25.9</a> kernel, and still saw the same problem. It seems to have something to<br>do with uml&#39;s signal handling. Does anyone know what changes in 2.6.25 uml code that<br>
may cause the problem? Thanks a lot!<br><br>Jiaying<br></div><br>

------=_Part_14135_22042807.1215071626838--


--===============0852991849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============0852991849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0852991849==--

