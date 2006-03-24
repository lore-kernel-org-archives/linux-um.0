Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <44237796.5080803@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Resend: how to debug module on UML kernel 2.6.15.6
	+ 	SKAS mode?
References: <442366BA.3080902@gmail.com>
In-Reply-To: <442366BA.3080902@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE7A86A84C541415B71F5423C"
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
Date: Thu, 23 Mar 2006 23:37:42 -0500
To: mikado4vn@gmail.com
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE7A86A84C541415B71F5423C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

i think everytime you load it and unload it you may get different address=
es

so you want a few more things in the [Host](gdb) section before loading
a module these stepd should allow you to debug a module_init routine

1) from http://kgdb.linsyssoft.com/downloads/miscmacros
    we get an idea how to address modules from within gdb

#Miscellaneous macros
define lsmod
    set $mod =3D (struct module*)module_list
    # the last module is the kernel, ignore it
    while $mod !=3D &kernel_module
    	printf "%p\t%s\n", (long)$mod, ($mod)->name
	set $mod =3D $mod->next
    end
end

2) you need a break point in module.c (sys_init_module) where we have
    the mod pointer in hand and are about to call init. like here in 2.4.=
26

    /* Initialize the module.  */
    atomic_set(&mod->uc.usecount,1);
    mod->flags |=3D MOD_INITIALIZING;
    if (mod->init && (error =3D mod->init()) !=3D 0) {

3) so when you set this break point you want to do something like this:

    (gdb)break module.c:553
    # note the breakpoint number xx
    (gdb)commands xx
         printf "add-symbol-file %s\t%p\n", ($mod)->name, (long)$mod +
$mod->size_of_struct
         end

Note the extra size_of_struct to point to the correct area.

Cut-and-Paste the resulting line into your gdb window.
Assuming the path to your module is in the gdb session 'dir' path
(if not you can point it to using a path to the .o)

your symbols should load and you should be able to step into
mod->init() with code you can read.

db

Mikado wrote:
>
> - How can I debug loadable modules at run time?
>
> Here is my way:
>
>   ( /tmp/mymodule.ko exists on both [Host] and [UML] )
>   + [Host] # gdb linux
>   + [Host] (gdb) ...
>   + [Host] (gdb) r <params>
>   + [UML] # insmod /tmp/mymodule.ko
>   + [UML] # cat /sys/module/mymodule/sections/{.text,.bss,.data}
>   + [Host] (gdb) add-symbol-file /tmp/mymodule.ko <.text_addr> -s .bss
> <.bss_addr> -s .data <.data_addr>
>   + ...
>
> Tell me if I was wrong, thanks!
>
> - How can I set breakpoint at module's init function?
>
> After add module's symbol, I set breakpoint at init function then
> 'rmmod' then re-'insmod' but gdb didn't break at init function. What wa=
s
> wrong?
>
> - Sometimes gdb can't follow source codes in '.h' header files. Did I
> miss something?
>
> Thanks in advance,
> Mikado.



--------------enigE7A86A84C541415B71F5423C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iD8DBQFEI3ef3XQ4zakZ3z4RAlWnAJ0X8C28GdeOxS/XuDy6v2jo6TL7CwCfRGBk
GLdsIgOz+GCRJ9ABFn2SyyU=
=Uc/f
-----END PGP SIGNATURE-----

--------------enigE7A86A84C541415B71F5423C--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
