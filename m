Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1PUm-0004fe-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 05:08:48 -0700
Received: from pluto.nixia.no ([195.159.42.3])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A1PUl-0001p9-9u
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 22 Sep 2003 05:08:47 -0700
Message-ID: <29962.193.212.97.12.1064224575.squirrel@pluto.nixia.no>
In-Reply-To: <3F6DFD84.8090309@davidcoulson.net>
References: <20030921183013.99560.qmail@web80507.mail.yahoo.com> 
     <3F6DFD84.8090309@davidcoulson.net>
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
Date: Mon, 22 Sep 2003 11:56:15 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

> Terry wrote:
>> I created the filesystem on the host os with dd.  I
>> boot up my vm with ubd3=/uml/new_fs as a kernel
>> argument.  WHen inside the VM, I create an ext2
>> filesystem on it.  I am then able to mount it normally
>> from there.  When I add it to fstab as:
>> /dev/ubd/3     /usr            ext2    defaults 1 1
>> It blows chunks.
>
> What's the error message? What command line are you starting UML with?
> You need to give us some information to actually debug the problem.

Do you get a kernel crashing, or just rc stuff failing due to most of all
shell-tools and stuff lies under /usr/bin, and therefor needs to be
mounted very early during the boot.


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
