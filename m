Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9ITt-0003Y4-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 13 Oct 2003 23:16:29 -0700
Received: from fed1mtao08.cox.net ([68.6.19.123])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9ITs-0001La-Gd
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 13 Oct 2003 23:16:28 -0700
Message-ID: <3F8B9570.6080404@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] filemap feature 2.4.22-5um
References: <BAY7-F67zjLYL23VZvZ0000e11f@hotmail.com>
In-Reply-To: <BAY7-F67zjLYL23VZvZ0000e11f@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Mon, 13 Oct 2003 23:19:28 -0700
To: Steve Schmidtke <steve_schmidtke@hotmail.com>, user-mode-linux-devel@lists.sourceforge.net

Steve,

I like your file mapping, especially as a way of keeping a chroot jail 
as empty as possible.

A couple of questions.  I noticed that you are not mapping /proc/mm.  Is 
this a 2.4.x only issue or is this needed in SKAS mode with 2.6.x.  I am 
running 2.4.22 with all of my virtuals just to keep things "stable".  I 
also tend to see a "lot" of open handles to /proc/mm.  Sometimes >50 of 
these.  This looks like one per virtual process (minus threads).  Am I 
reading this right.

On virtuals that I run, I tend to only see a single "vm" file opened:

linux   5595 root    3u   REG       58,0 268435457 4941730 
/usr2/vsys/v_2020/tmpdir/vm_file-OeeMw1 (deleted)

This one is 256Meg.  When does the vm try to open "pieces".

Is there any reason the tun/tap networking wouldn't work with this 
layout by pre-opening /dev/net/tun.

Thanks for the script examples of how to get this rolling.

---
Doug Dumitru

Steve Schmidtke wrote:

> This patch adds filemap support to 2.4.22-5um.  The function of this 
> patch is an awkard and convoluted solution to an arcane problem.  Unless 
> you know this is what you need, you may just want to skip this post.
> 
> Filemaping is a method of mapping open file descriptors to arbitrary 
> file names within a UML.  Once a file name has been mapped, all UML file 
> requests on that name act upon the open file descriptor.  The main 
> purpose of filemap is to support empty chroot environments, allowing the 
> UML to access files, such as /proc/cpuinfo and virtual memory files, 
> without requiring those files to be present within the chroot directory.
> 
> The filemap boot string syntax lookes like this:
> 
>  filemap=<table>,<table specific syntax>
> 
> There are two tables available, "file" and "vm".  "file" type filemaps 
> handle fd/filename pairs, while "vm" type filemaps handle pools of fd's 
> that represent virtual memory files.
> 
> For example, a "file" table boot string may look like this:
> 
>  filemap=file,12,/proc/cpuinfo
> 
> which redirects the UML to file descriptor 12 when accessing the file
> /proc/cpuinfo.  In this case, file descriptor 12 must be opened 
> beforehand, possibly like this on the UMLs command line:
> 
>  12</proc/cpuinfo
> 
> A "vm" table filemap boot string may look like this:
> 
>  filemap=vm,20-23
> 
> which will set up a pool of file descriptors (20, 21, 22, and 23) to be 
> mete out to the UML as it requests virtual memory files.
> 
> Here are some example command lines using filemaps:
> 
>  chroot /home/uml /bin/linux mem=32M \
>  filemap=file,11,/proc/cpuinfo 11</proc/cpuinfo
> 
> The above line tells the chrooted UML to use file descriptor 11 whenever 
> accessing /proc/cpuinfo (which it only ever reads).
> 
>  chroot /cdrom /linux mem=16M filemap=vm,20-21 \
>  20<>/dev/shm/vm1 21<>/dev/shm/vm2
> 
> This invocation tells the chrooted UML to use file descriptors 20 and 21 
> for (some of) its virtual memory files.  How do you know how many to 
> specify?  The number is proportional to how much memory you have given 
> the UML. Start with booting the UML with a bunch of zero length files, 
> and review how many end up with non-zero file sizes.  Adjust to suit.  
> Note the above examples read+write redirection on the vm files.
> 
>  umlwrap -bind=22,/dev/shm/mconsole1 -dir=/home/uml -- \
>  /bin/linux mem=48M uml_dir=/uml/ umid=um1 filemap=22,/uml/um1/pid \
>  22</dev/shm/pid filemap=22,/uml/um1/mconsole
> 
> Here, a hypothetical chroot helper opens a bound unix socket on file 
> descriptor 21.  The chrooted UML will pick up the fd as its mconsole 
> socket (by way of a crafty command line).  Note that the method used to 
> tell uml_mconsole to open a socket in /dev/shm/ is beyond the scope of 
> this example.  Also note that the umid pid file has been filemaped as 
> well -- the umid directory does not have to exist for things to work.
> 
> In fact, there is no writable media necessary within the chroot to run 
> UML at all.  The only file necessary to be present is the staticly 
> linked linux binary.
> 
> One final example to put it all together:
> 
>  umlwrap -bind=15,/dev/shm/mconsole-$$ -connect=17,/tmp/uml.ctl \
>  -dir=/home/uml -user=guest -- /bin/linux mem=64M \
>  uml_dir=/uml/ umid=um$$ ubd0=/disk.cow,/disk.dat \
>  eth0=daemon con=null con0=fd:0,fd:1 \
>  filemap=file,10,/proc/cpuinfo 10</proc/cpuinfo \
>  filemap=file,11,/disk.dat 11</mnt/backing.dat \
>  filemap=file,12,/disk.cow 12<>/home/uml/cow-$$.cow \
>  filemap=file,15,/uml/um$$/mconsole \
>  filemap=file,16,/uml/um$$/pid 16</dev/shm/pid-$$ \
>  filemap=file,17,/tmp/uml.ctl \
>  filemap=vm,20-23 20<>/dev/shm/vm-$$.0 21<>/dev/shm/vm-$$.1 \
>  22<>/dev/shm/vm-$$.2 23<>/dev/shm/vm-$$.3 \
> 
> Ugly, isn't it.  If you find a nicer way to do this let me know.  Notice 
> how networking is carried out here via the daemon transport, connecting 
> to the /tmp/uml.ctl socket run by uml_switch.  Your mileage may vary.
> 
> Other filemap issues I know about:
> 
> - Reboots may not work as expected.  Best is to shutdown and restart.
> - A given file may be corrupted if access to it is not serialized.
> - Hostfs accessed files are NOT filemapped.  See above.
> - Directories cannot be filemapped.
> - Vm files are visible and persistent!  Bug or feature:  you decide.
> - Notify feature of mconsole is not supported.  Why so complicated?
> - You can bet this patch won't make it into Jeff's official source 
> tree.  I'm cool with that.
> 
> Enjoy!
> 
> Steve Schmidtke
> 
> _________________________________________________________________
> The new MSN 8: advanced junk mail protection and 2 months FREE*  
> http://join.msn.com/?page=features/junkmail


-- 

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------
D3, U2, jBase Virtual Servers.    Off-site backup over the internet.
Develop/test/deploy from $20/mo.  Fast, secure, cheaper than tape.
http://mirroredservers.com        http://mirroredbackup.com



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
