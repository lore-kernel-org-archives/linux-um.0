Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1Tu5rl-0006hd-NZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 18:31:37 +0000
Received: from i01.ip.uk.com ([86.54.60.3])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tu5rV-0008Ub-Q7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 18:31:37 +0000
From: "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>
Message-ID: <1492014.5OhtFxJ3yI@vault01>
In-Reply-To: <20130112105812.4eedc505@spider.haslach.nod.at>
References: <50F132F9.1030601@bob-the-boat.me.uk>
	<20130112105812.4eedc505@spider.haslach.nod.at>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Date: Sat, 12 Jan 2013 18:31:38 +0000
Subject: [uml-devel] Network related UML Crashing
To: Richard Weinberger <richard@sigma-star.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

Re: [uml-devel] "Couldn't grant pty"

Now that I have been able to run the Debiam 32 bit root_fs, I have returned to 
the network related crashing.

This is by way of a status update, I will do more to tie down what is required 
to demonstrate the problem as simply as possible.

However:

root@DEB1-32:~# rsync --archive --progress 10.0.10.30:/var/imap/ /var/imap/
The authenticity of host '10.0.10.30 (10.0.10.30)' can't be established.
RSA key fingerprint is ce:e4:0d:88:c0:07:01:8d:10:f8:91:52:b5:4b:e1:53.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '10.0.10.30' (RSA) to the list of known hosts.
receiving incremental file list
./
.bash_history
        1970 100%    1.88MB/s    0:00:00 (xfer#1, to-check=1005/1007)
config/
config/annotations.db
         144 100%    0.23kB/s    0:00:00 (xfer#2, to-check=1356/1362)
config/deliver.db
           0   0%    0.00kB/s    0:00:00  ------------[ cut here ]------------


This is what happened on the Debian 32 bit system with the 3.8.0-rc3 UML 
kernel.

The DEB1 UML is now completely dead and locked up, no further messages escaped 
after this point.

If I try to kick it with uml_mconsole:

bash-4.1# uml_mconsole DEB1
(DEB1) halt

and nothing more happens.

10.0.10.30 is another 32 bit UML.

DEB1-32 is the Debian UML, with an IP address of 10.0.10.31.

Networking is via mcast.

This behaviour is consistent with what I have found all along.

I have seen the same on a 32 bit UML running on a genuinely 32 bit machine 
that is remote to my current location and which I access via the Internet, so 
the problem arises using real ethernet (via tun-tap) as well as mcast; and in 
a genuine 32 bit environment.

I will try to characterise this more fully, and simplify the method of causing 
failure as much as possible.

I still believe that there is a real problem here, not just me doing something 
stupid.

Regards,
David


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122912
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

