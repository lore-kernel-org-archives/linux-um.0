Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2bfj-0002A6-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 12:21:03 -0700
Received: from pluto.nixia.no ([195.159.42.3])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A2bfi-00051a-S8
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 25 Sep 2003 12:21:03 -0700
Message-ID: <1337.62.97.174.68.1064509678.squirrel@pluto.nixia.no>
In-Reply-To: <20030925184539.19093.qmail@web60302.mail.yahoo.com>
References: <3F6DFD84.8090309@davidcoulson.net> 
     <20030925184539.19093.qmail@web60302.mail.yahoo.com>
Subject: Re: [uml-devel] mounting filesystems - mount crashes
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 25 Sep 2003 19:07:58 +0200 (CEST)
To: Terry <td3201@yahoo.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Or Manually with fstab:
> mount /usr.new
> Child 23701 exited with signal 11
>
> I can get it mounted in the following ways:
> mount /dev/ubd/3 /usr
> mount -a (if its in fstab)

Since you are able to trigger the fault now, you can take a peek behind
the sceenes and play with strace.

strace mount /dev/ubd/3 /usr

and

strace mount /usr.new

normally should produce the same output and outfall for you.


Stian


This mail has been scanned for known viruses on an open, Linux-based mailsystem
developed by http://Knowledge-Network.no and http://Nixia.no.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
