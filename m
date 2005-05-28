Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dbzc8-0003AI-Rz	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 04:36:24 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Dbzc5-0006PD-So	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 04:36:24 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 4/4] uml: make it link in tt mode against
	NPTL glibc
References: <20050527004024.606961AEE9A@zion.home.lan>
	<20050527042041.GC29811@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050527042041.GC29811@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281338.22412.blaisorblade@yahoo.it>
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
Date: Sat, 28 May 2005 13:38:22 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Friday 27 May 2005 06:20, Al Viro wrote:
> On Fri, May 27, 2005 at 02:40:24AM +0200, blaisorblade@yahoo.it wrote:
> > To make sure switcheroo() can execute when we remap all the executable
> > image, we used a trick to make it use a local copy of errno... this trick
> > does not work with NPTL glibc, only with LinuxThreads, so use another
> > (simpler) one to make it work anyway.
> >
> > Might need compile testing on different host archs, since it changes
> > __syscall_return from <asm/unistd.h>.
>
> For one thing, it's broken since mmap2() doesn't exist on amd64.  This
> stuff *is* low-level - as low-level as it gets.
> It's clearly 
> per-architecture.
Yes, agreed.
> See ftp.linux.org.uk/pub/people/viro/UM14-unmap-RC12-rc4 
> for a fix...
Seems reasonable except that on i386 you keep the old linker script, indeed; I 
think that the linker script shouldn't be per architecture.

Also (not verified) one section is either read-write or read-only, so 
merging .bss and .text does not seem good to me (I separated them on 
purpose).

Good catch for using .bss instead of .data.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
