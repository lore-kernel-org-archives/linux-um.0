Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I4Lvc-0000ki-6m for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Jun 2007 12:14:48 -0700
Received: from wr-out-0506.google.com ([64.233.184.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I4Lvb-00041F-OG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Jun 2007 12:14:48 -0700
Received: by wr-out-0506.google.com with SMTP id i22so803000wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Jun 2007 12:14:46 -0700 (PDT)
Message-ID: <9604cc9f0706291214y92b1d49w198c59a5563acded@mail.gmail.com>
Date: Fri, 29 Jun 2007 20:14:45 +0100
From: "kototama kototama" <kototamo@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] Deadlock when calling securityfs_create_dir
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1721486645=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: UML-user <user-mode-linux-devel@lists.sourceforge.net>

--===============1721486645==
Content-Type: multipart/alternative; 
	boundary="----=_Part_24119_16674578.1183144485702"

------=_Part_24119_16674578.1183144485702
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

After mounting securityfs like this:

uml# mount securityfs -t securityfs /sys/kernel/security

I load a module which performs these operations:


static void securityfs_init(void)
{
        struct dentry *de;


        printk(KERN_ALERT "securityfs_init\n");
        de = securityfs_create_dir("berlinfw2", NULL);
        if(!de) {
                printk(KERN_ALERT "Can't create security directory\n");
        }
}


Then I've got a deadlock, interruption uml, and showing the stackstrace
gives that:

#0  hard_handler (sig=11) at arch/um/os-Linux/sys-i386/signal.c:11
#1  <signal handler called>
#2  0x081b76da in mutex_lock (lock=0x40162068) at
include/asm/arch/atomic.h:189
#3  0x0812dfbb in create_by_name (name=0xa81b09c "<1>securityfs_init\n",
mode=16877, parent=0x95a3f1c,
    dentry=0x95a3ec8) at security/inode.c:173
#4  0x0812e0e0 in securityfs_create_file (name=0xa81b09c
"<1>securityfs_init\n", mode=16877, parent=0x95a3f1c,
    data=0x0, fops=0x0) at security/inode.c:231
#5  0x0812e160 in securityfs_create_dir (name=0xa81b09c
"<1>securityfs_init\n", parent=0x95a3f1c)
    at security/inode.c:272
#6  0x0a81b04a in ?? ()
#7  0x0a81b09c in ?? ()
#8  0x095a3f1c in ?? ()
#9  0x0809de76 in sys_init_module (umod=0x821aab4, len=1, uargs=0xa81b440
"\001") at kernel/module.c:1991

The module works fine on the host. The host kernel is
2.6.20-16-generic(ubuntu feisty fawn), the uml kernel is compiled from
ubuntu sources.

It seems there is a memory problem in the frame #5, the argument of the call
is wrong!

Any ideas ?

------=_Part_24119_16674578.1183144485702
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>After mounting securityfs like this:<br><br>uml# mount securityfs -t securityfs /sys/kernel/security <br><br>I load a module which performs these operations:<br><br><br>static void securityfs_init(void)<br>{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *de;<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ALERT &quot;securityfs_init\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de = securityfs_create_dir(&quot;berlinfw2&quot;, NULL);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!de) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ALERT &quot;Can&#39;t create security directory\n&quot;);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>}<br><br><br>Then I&#39;ve got a deadlock, interruption uml, and showing the stackstrace gives that:<br><br>#0&nbsp; hard_handler (sig=11) at arch/um/os-Linux/sys-i386/signal.c:11<br>#1&nbsp; &lt;signal handler called&gt;
<br>#2&nbsp; 0x081b76da in mutex_lock (lock=0x40162068) at include/asm/arch/atomic.h:189<br>#3&nbsp; 0x0812dfbb in create_by_name (name=0xa81b09c &quot;&lt;1&gt;securityfs_init\n&quot;, mode=16877, parent=0x95a3f1c, <br>&nbsp;&nbsp;&nbsp; dentry=0x95a3ec8) at security/inode.c:173
<br>#4&nbsp; 0x0812e0e0 in securityfs_create_file (name=0xa81b09c &quot;&lt;1&gt;securityfs_init\n&quot;, mode=16877, parent=0x95a3f1c, <br>&nbsp;&nbsp;&nbsp; data=0x0, fops=0x0) at security/inode.c:231<br>#5&nbsp; 0x0812e160 in securityfs_create_dir (name=0xa81b09c &quot;&lt;1&gt;securityfs_init\n&quot;, parent=0x95a3f1c)
<br>&nbsp;&nbsp;&nbsp; at security/inode.c:272<br>#6&nbsp; 0x0a81b04a in ?? ()<br>#7&nbsp; 0x0a81b09c in ?? ()<br>#8&nbsp; 0x095a3f1c in ?? ()<br>#9&nbsp; 0x0809de76 in sys_init_module (umod=0x821aab4, len=1, uargs=0xa81b440 &quot;\001&quot;) at kernel/module.c:1991
<br><br>The module works fine on the host. The host kernel is 2.6.20-16-generic (ubuntu feisty fawn), the uml kernel is compiled from ubuntu sources.<br><br>It seems there is a memory problem in the frame #5, the argument of the call is wrong!
<br><br>Any ideas ?<br>

------=_Part_24119_16674578.1183144485702--


--===============1721486645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1721486645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1721486645==--

