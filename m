Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMwBO-0007DR-IA for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 15:59:06 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMwBM-00089b-0F
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 15:59:06 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
	<20060324144535.37b3daf7.akpm@osdl.org>
In-Reply-To: <20060324144535.37b3daf7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603250058.57700.blaisorblade@yahoo.it>
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
Date: Sat, 25 Mar 2006 00:58:57 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Friday 24 March 2006 23:45, Andrew Morton wrote:
> Jeff Dike <jdike@addtoit.com> wrote:

> > Unplugged pages are allocated and then madvise(MADV_REMOVE), 

> > This patch also removes checking for /dev/anon on the host, which is
> > obsoleted by MADVISE_REMOVE.

>  * NOTE: Currently, only shmfs/tmpfs is supported for this operation.
>  * Other filesystems return -ENOSYS.

> Are you expecting that this memory is backed by tmpfs?

Yes, that's the recommended configuration, and we're going to move the default 
position for the backing file to /dev/shm.

However, it's bogus to miss any error handling - possibly not returning err is 
wanted (dunno) because Jeff wants to pretend it succeeded anyway, but at 
least a printk() to inform the user that memory must lay on tmpfs is 
required.

> +int os_drop_memory(void *addr, int length)
> +{
> +     int err;
> +
> +     err = madvise(addr, length, MADV_REMOVE);
> +     if(err < 0)
> +             err = -errno;

Jeff, did you mean the "return _0_" rather than "return err" below? It's 
incoherent with the existance of the "err" local.

> +     return 0;
> +}

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
