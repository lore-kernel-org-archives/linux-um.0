Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2b7y-00079m-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 11:46:10 -0700
Received: from web60302.mail.yahoo.com ([216.109.118.113])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A2b7x-0007hw-Ph
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 25 Sep 2003 11:46:09 -0700
Message-ID: <20030925184539.19093.qmail@web60302.mail.yahoo.com>
From: Terry <td3201@yahoo.com>
Subject: Re: [uml-devel] mounting filesystems - mount crashes
In-Reply-To: <3F6DFD84.8090309@davidcoulson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 25 Sep 2003 11:45:39 -0700 (PDT)
To: user-mode-linux-devel@lists.sourceforge.net

--- David Coulson <david@davidcoulson.net> wrote:
> Terry wrote:
> > I created the filesystem on the host os with dd. 
> I
> > boot up my vm with ubd3=/uml/new_fs as a kernel
> > argument.  WHen inside the VM, I create an ext2
> > filesystem on it.  I am then able to mount it
> normally
> > from there.  When I add it to fstab as:
> > /dev/ubd/3     /usr            ext2    defaults 1
> 1
> > It blows chunks.  
> 
> What's the error message? What command line are you
> starting UML with? 
> You need to give us some information to actually
> debug the problem.
> 
> David

During the boot process:
Mounting local filesystems:  Child 28884 exited with
signal 11

Or Manually with fstab:
mount /usr.new
Child 23701 exited with signal 11

I can get it mounted in the following ways:
mount /dev/ubd/3 /usr
mount -a (if its in fstab)

I start UML with:
./linux ubd0=/home/td/uml/root_fs
ubd1=/home/td/uml/home_fs ubd2=/home/td/uml/swap
ubd3=/home/td/uml/usr_fs eth0=tuntap,,,192.168.0.254
mem=512M

I took a peek at the script that mounts filesystems
and it is pretty basic.

Any ideas on how to get around this?  It works if I
put the mount command in rc.local but I need the
filesystem way before that gets ran.

Thanks.

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
