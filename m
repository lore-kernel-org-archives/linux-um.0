Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D965Q-0001wH-9p for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 10:39:12 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D965O-0000JH-5P for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 10:39:11 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Fw: [patch] uml: terminal cleanup
References: <20041128010910.1b5478c7.akpm@osdl.org>
	<200503051858.05050.blaisorblade@yahoo.it>
	<20050308082502.GB23067@bytesex>
In-Reply-To: <20050308082502.GB23067@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503091938.46936.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 9 Mar 2005 19:38:46 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>

On Tuesday 08 March 2005 09:25, Gerd Knorr wrote:
> > > -void register_winch(int fd, void *device_data)
> > > +void register_winch(int fd, struct tty_struct *tty)
> > >  {
> > >   int pid, thread, thread_fd;
> > >   int count;

> > > -void line_close(struct line *lines, struct tty_struct *tty)
> > > +void line_close(struct tty_struct *tty, struct file * filp)
> > >  {
> > > - struct line *line;
> > > - int n;
> > > -
> > > - if(tty == NULL) n = 0;
> > > - else n = tty->index;
> > > - line = &lines[n];
> > > + struct line *line = tty->driver_data;
> > >
> > >   down(&line->sem);
> > >   line->count--;
> > > -
> > > - /* I don't like this, but I can't think of anything better.  What's
> > > -  * going on is that the tty is in the process of being closed for
> > > -  * the last time.  Its count hasn't been dropped yet, so it's still
> > > -  * at 1.  This may happen when line->count != 0 because of the
> > > initial -  * console open (without a tty) bumping it up to 1.
> > > -  */
> > > - if((line->tty != NULL) && (line->tty->count == 1))
> > > -  line->tty = NULL;
> > > - if(line->count == 0)
> > > -  line_disable(line, -1);
> > > + if (tty->count == 1) {
>
> Hmm, while looking at this again, I think maybe this should be
> "tty->count == 0" (it's _behind_ the line->count-- after all ...).

> Guess you are writing me because you are trying to pin down a bug,
> maybe that one is it ;)
No, because I got to properly read this just now.
> > > +  line_disable(tty, -1);
> > > +  tty->driver_data = NULL;
> > > + }
> > >   up(&line->sem);
> > >  }
> >
> > Why did you delete this comment? I don't think you fixed the problem, you
> > just worked it around the other way...
>
> No, it's fixed.
Well, if the above gets corrected (tty->count == 0 or 1), I think it's ok.

> Drawback of that is that is that you don't see any messages until the
> stdio console is initialized.  That isn't a big problem if the kernel
> survives up to this point as the console code will simply print all
> messages buffered up so far as soon as the console device is opened.

> But if the kernel dies early you don't see the messages.  In that case
> the new stderr console will help, which can be enabled with "stderr=1"
> in the kernel cmd line (maybe additionally "console=stderr") and which
> is simple enougth that it can register very early in the boot process.

No, this does not happen... the normal situation currently is that the kernel 
skips printing part of the initial output.

Sample output (note ject_hotplug - it's actually a truncated part of a longer 
message)

$ ./OldKernels/vmlinux-2.6.11-rc3
Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
Checking PROT_EXEC mmap in /tmp...OK
ject_hotplug - call_usermodehelper returned -1
io scheduler noop registered
NET: Registered protocol family 2
IP: routing cache hash table of 256 buckets, 4Kbytes
TCP established hash table entries: 2048 (order: 3, 32768 bytes)
TCP bind hash table entries: 2048 (order: 2, 24576 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(98,0)
 <6>Stopping all CPUs...done
(stack trace).

$ ./OldKernels/vmlinux-2.6.11-rc3 stderr=1
Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.11-rc3 (paolo@zion) (gcc version 3.3.2 (Mandrake Linux 10.0 
3.3.2-6mdk)) #10 SMP Thu Feb 3 23:38:59 CET 2005
Built 1 zonelists
Kernel command line: stderr=1 root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 27896k available
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Brought up 1 CPUs
NET: Registered protocol family 16
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
mconsole (version 2) initialized on /home/paolo/.uml/GElkTZ/mconsole
ubd: Synchronous mode
audit: initializing netlink socket (disabled)
audit(300.260:0): initialized
Initializing Cryptographic API
io scheduler noop registered
NET: Registered protocol family 2
IP: routing cache hash table of 256 buckets, 4Kbytes
TCP established hash table entries: 2048 (order: 3, 32768 bytes)
TCP bind hash table entries: 2048 (order: 2, 24576 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
Initialized stdio console driver
Initializing software serial port version 1
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(98,0)

$ ./vmlinux-2.6.11-rc4-bk-testLock-nofix console=stderr
Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
Checking PROT_EXEC mmap in /tmp...OK

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
