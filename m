Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Aee72-0002Ec-BE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jan 2004 09:38:28 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Aee71-00040O-Ko for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jan 2004 09:38:27 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [tracked down] Kernel mode fault with /dev/kmem
References: <Pine.LNX.4.44.0401071254540.1058-100000@gradall.private.brainfood.com>
In-Reply-To: <Pine.LNX.4.44.0401071254540.1058-100000@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200401081834.44045.blaisorblade_spam@yahoo.it>
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
Date: Thu, 8 Jan 2004 18:34:43 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:18, mercoled=EC 7 gennaio 2004, Adam Heath ha scritto:
> On Thu, 8 Jan 2004, Jeff Chua wrote:
> > open("/dev/kmem", O_RDONLY)             =3D 3
> > _llseek(0x3, 0, 0xa8965000, 0xbffff934, 0) =3D 0
> > read(3, Kernel panic: Kernel mode fault at addr 0x48965000, ip 0x400df1=
a4
>
> 0xa8965000 !=3D 0x48965000
>
> Note how only the first octet is different.

Ok, excellent note; or better, that behaviour (a different address) *is*=20
right, but the difference is *wrong*.

Reading the code of read_kmem as patched, we get this pseudo-code:

p=3D*ppos; //position pointer
...
p =3D __va(p); /*translate physical address to virtual, like: */
//p +=3D uml_physmem;

However, starting from 0xa8965000, and increasing it by 2,5Gb, we get an=20
overflow, i.e. p becomes <old p> + 2,5Gb - 4Gb =3D <old p> - 1,5 Gb=3D0x489=
65000.

So we've got to the bug. But anyway, doing p=3D__va(p) is a wrong fix becau=
se an=20
offset inside /dev/kmem is already virtual (comments in the file are clear)=
,=20
and in read_mem we see:
  copy_to_user(buf, __va(p), count).

So, the patch just turns /dev/kmem into /dev/mem, on reading, while it does=
n't=20
do the overflow check done inside read_mem. On writing, instead, it changes=
=20
nothing, so we would have probably other panics.

What I've read about the patch was that the kmem driver "incorrectly assume=
s=20
the address space starts from the 0 address", IIRC. If this is correct, the=
n=20
the correct fix would be to check whether the address is mapped and to=20
provide a suitable error code, either -EFAULT, or 0, as here:

static ssize_t read_mem(struct file * file, char * buf,
                        size_t count, loff_t *ppos) {
        unsigned long p =3D *ppos;
        unsigned long end_mem;
        ssize_t read;

        end_mem =3D __pa(high_memory);
        if (p >=3D end_mem)
                return 0;
	/*...*/
}

However, I'm not up to see how to exactly do the check (even if this check =
is=20
already done when using the copy_from_user macros).

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
