Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GT1rv-0002ci-8g for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Sep 2006 12:48:27 -0700
Received: from aa012msr.fastwebnet.it ([85.18.95.72])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GT1rt-00038p-JQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Sep 2006 12:48:27 -0700
Date: Thu, 28 Sep 2006 21:47:27 +0200
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20060928194727.GC8519@inferi.kami.home>
References: <2flhcyrq2nr.fsf@saruman.uio.no>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2flhcyrq2nr.fsf@saruman.uio.no>
Subject: Re: [uml-devel] [Pkg-uml-pkgs] How is user-mode-linux using /dev/shm/?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Petter Reinholdtsen <pere@hungry.com>
Cc: User Mode Linux Maintainers <pkg-uml-pkgs@lists.alioth.debian.org>, pkg-sysvinit-devel@lists.alioth.debian.org, Paolo Giarrusso <blaisorblade@yahoo.it>, UML-devel <user-mode-linux-devel@lists.sourceforge.net>

Thanks Petter for writing, 
I was going to followup to the sysvinit bug :)

I'm Cc-ing upstream too.

On Thu, Sep 28, 2006 at 08:14:32PM +0200, Petter Reinholdtsen wrote:
> 
> Hi
> 
> I am one of the sysvinit maintainers.  Recently we changed the mount
> options of /dev/shm/, and got a bug report about uml refusing to start
> (#386945).  Because of this, I am curious how uml uses /dev/shm/.  Is
> it using the shm-functions in glibc, or something else?  Please
> explain how it work.

I don't think it uses shm* functions, as far as I can tell the /dev/shm
location is sensible to $TMP, $TEMP or $TEMPDIR, thus changing one of
them to a different location goes farther than what's reported in the
bureport:

$ TMPDIR=./TMP linux ubd0=rootfs_debian-sid.172.20.0.20 ubd1=swap-172.20.0.20 eth0=tuntap,,,172.20.0.19 umid=debian mem=128
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in ./TMP/...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Mapping memory: Cannot allocate memory

Don't know now, it's maybe easy to fix, there's a nice global variable
set to "/dev/shm" in arch/um/os-Linux/mem.c and UML uses mkstemp() to
create files.

> To make some writable tmpfs available to those in need of such system,
> and to avoid using /dev/shm/ which is reserved for the shm-functions,
> I just uploaded sysvinit version 2.86.ds1-26.  It will mount a tmpfs
> on /lib/init/rw/ that can be used instead.  If /lib/init/rw/.ramfs
> exist, that mount point is a tmpfs.  I'm not sure if this last change
> will make it into Etch or not, but I hope so, to solve any problems
> with packages previously using /dev/shm/ as a generic tmpfs file
> system.

Well, I'd actually prefer if you could remove the noexec flag from
/dev/shm. I understand the security reasons given in the bugreport but
I'd prefer avoid having to deal with one more Debian-only (is it?)
thing given the soon to come general freeze. 

Thanks
-- 
mattia
:wq!

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
