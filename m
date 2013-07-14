Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51E25B20.7030906@gmx.de>
Date: Sun, 14 Jul 2013 10:02:40 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: sunrpc/clnt.c: BUG kmalloc-256 (Not tainted): Poison overwritten
To: Linux NFS mailing list <linux-nfs@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This bisected commit produces at a 32 bit user mode linux guest the att=
ached BUG :

commit eeee245268c951262b861bc1be4e9dc812352499
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Jul 10 15:33:01 2013 -0400

    SUNRPC: Fix a deadlock in rpc_client_register()

    Commit 384816051ca9125cd54750e59c780c2a2655fa4f (SUNRPC: fix races =
on
    PipeFS MOUNT notifications) introduces a regression when we call
    rpc_setup_pipedir() with RPCSEC_GSS as the auth flavour.

    By calling rpcauth_create() while holding the sn->pipefs_sb_lock, w=
e
    end up deadlocking in gss_pipes_dentries_create_net().
    Fix is to register the client and release the mutex before calling
    rpcauth_create().

    Reported-by: Weston Andros Adamson <dros@netapp.com>
    Tested-by: Weston Andros Adamson <dros@netapp.com>
    Cc: Stanislav Kinsbursky <skinsbursky@parallels.com>
    Cc: <stable@vger.kernel.org> # : 3848160: SUNRPC: fix races on Pipe=
=46S MOUNT
    Cc: <stable@vger.kernel.org> # : e73f4cc: SUNRPC: split client crea=
tion
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>






2013-07-13T22:09:07.000+02:00 trinity sm-notify[1042]: Version 1.2.6 st=
arting
2013-07-13T22:09:07.000+02:00 trinity sm-notify[1042]: Backgrounding to=
 notify hosts...
2013-07-13T22:09:07.000+02:00 trinity sm-notify[1043]: Running as root.=
  chown /var/lib/nfs to choose different user
2013-07-13T22:09:10.000+02:00 trinity mount[1047]: mount to NFS server =
'n22stab4' failed: No route to host, retrying
2013-07-13T22:09:11.000+02:00 trinity dhcpcd[971]: eth0: sending IPv6 R=
outer Solicitation
2013-07-13T22:09:11.000+02:00 trinity dhcpcd[971]: eth0: no IPv6 Router=
s available
2013-07-13T22:09:13.000+02:00 trinity mount[1048]: mount to NFS server =
'n22stab4' failed: No route to host, retrying
2013-07-13T22:09:13.647+02:00 trinity kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2013-07-13T22:09:13.647+02:00 trinity kernel: BUG kmalloc-256 (Not tain=
ted): Poison overwritten
2013-07-13T22:09:13.647+02:00 trinity kernel: -------------------------=
----------------------------------------------------
2013-07-13T22:09:13.647+02:00 trinity kernel:
2013-07-13T22:09:13.647+02:00 trinity kernel: Disabling lock debugging =
due to kernel taint
2013-07-13T22:09:13.647+02:00 trinity kernel: INFO: 0x49b1ed18-0x49b1ed=
1b. First byte 0x74 instead of 0x6b
2013-07-13T22:09:13.647+02:00 trinity kernel: INFO: Allocated in rpc_ne=
w_client+0x81/0x3a0 age=3D300 cpu=3D0 pid=3D1049
2013-07-13T22:09:13.647+02:00 trinity kernel: INFO: Freed in rpc_new_cl=
ient+0x35a/0x3a0 age=3D300 cpu=3D0 pid=3D1049
2013-07-13T22:09:13.647+02:00 trinity kernel: INFO: Slab 0x0b87bac0 obj=
ects=3D13 used=3D13 fp=3D0x  (null) flags=3D0x0080
2013-07-13T22:09:13.647+02:00 trinity kernel: INFO: Object 0x49b1ed10 @=
offset=3D3344 fp=3D0x49b1ee40
2013-07-13T22:09:13.653+02:00 trinity kernel:
2013-07-13T22:09:13.653+02:00 trinity kernel: Bytes b4 49b1ed00: f6 03 =
00 00 bd 94 ff ff 5a 5a 5a 5a 5a 5a 5a 5a  ........ZZZZZZZZ
2013-07-13T22:09:13.653+02:00 trinity kernel: Object 49b1ed10: 6b 6b 6b=
 6b 6b 6b 6b 6b 74 3a 85 49 6b 6b 6b 6b  kkkkkkkkt:.Ikkkk
2013-07-13T22:09:13.653+02:00 trinity kernel: Object 49b1ed20: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.653+02:00 trinity kernel: Object 49b1ed30: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.653+02:00 trinity kernel: Object 49b1ed40: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.653+02:00 trinity kernel: Object 49b1ed50: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.653+02:00 trinity kernel: Object 49b1ed60: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.653+02:00 trinity kernel: Object 49b1ed70: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.653+02:00 trinity kernel: Object 49b1ed80: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.660+02:00 trinity kernel: Object 49b1ed90: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.660+02:00 trinity kernel: Object 49b1eda0: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.660+02:00 trinity kernel: Object 49b1edb0: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.660+02:00 trinity kernel: Object 49b1edc0: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.660+02:00 trinity kernel: Object 49b1edd0: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.660+02:00 trinity kernel: Object 49b1ede0: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.660+02:00 trinity kernel: Object 49b1edf0: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
2013-07-13T22:09:13.660+02:00 trinity kernel: Object 49b1ee00: 6b 6b 6b=
 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
2013-07-13T22:09:13.660+02:00 trinity kernel: Redzone 49b1ee10: bb bb b=
b bb                                      ....
2013-07-13T22:09:13.660+02:00 trinity kernel: Padding 49b1ee38: 5a 5a 5=
a 5a 5a 5a 5a 5a                          ZZZZZZZZ
2013-07-13T22:09:13.665+02:00 trinity kernel: CPU: 0 PID: 1030 Comm: rp=
c.idmapd Tainted: G    B        3.10.0-09292-g621fa28 #1
2013-07-13T22:09:13.665+02:00 trinity kernel: 48957a1c 48957a48 080f78b=
0 084ab0f8 49b1ed10 00000d10 49b1ee40 0b87bac0
2013-07-13T22:09:13.665+02:00 trinity kernel: 49b1ed18 00000004 49b1ed1=
b 48957a80 080f7e88 084ab1d8 49b1ed18 49b1ed1b
2013-07-13T22:09:13.665+02:00 trinity kernel: 00000074 0000006b 0000005=
a 49b1ed10 0b87bac0 49849c00 49849c00 49b1ed10 489579f0:  [<0805fb1f>] =
show_stack+0xcf/0x100
2013-07-13T22:09:13.665+02:00 trinity kernel: 48957a14:  [<0840345d>] d=
ump_stack+0x26/0x28
2013-07-13T22:09:13.665+02:00 trinity kernel: 48957a24:  [<080f78b0>] p=
rint_trailer+0xe0/0xf0
2013-07-13T22:09:13.665+02:00 trinity kernel: 48957a4c:  [<080f7e88>] c=
heck_bytes_and_report+0xa8/0x100
2013-07-13T22:09:13.665+02:00 trinity kernel: 48957a84:  [<080f7fb8>] c=
heck_object+0xd8/0x210
2013-07-13T22:09:13.665+02:00 trinity kernel: 48957ac0:  [<08401a84>] a=
lloc_debug_processing+0x7d/0x10e
2013-07-13T22:09:13.665+02:00 trinity kernel: 48957ae4:  [<084023cd>] _=
_slab_alloc.constprop.74+0x356/0x3a4
2013-07-13T22:09:13.673+02:00 trinity kernel: 48957b70:  [<080fae85>] _=
_kmalloc_track_caller+0x85/0x160
2013-07-13T22:09:13.673+02:00 trinity kernel: 48957b98:  [<082c90f3>] _=
_kmalloc_reserve.isra.47+0x33/0x90
2013-07-13T22:09:13.673+02:00 trinity kernel: 48957bc0:  [<082c9276>] _=
_alloc_skb+0x76/0x210
2013-07-13T22:09:13.673+02:00 trinity kernel: 48957bec:  [<082c65a1>] s=
ock_alloc_send_pskb+0xb1/0x320
2013-07-13T22:09:13.673+02:00 trinity kernel: 48957c34:  [<082c683e>] s=
ock_alloc_send_skb+0x2e/0x30
2013-07-13T22:09:13.673+02:00 trinity kernel: 48957c50:  [<08344831>] u=
nix_stream_sendmsg+0x161/0x3b0
2013-07-13T22:09:13.673+02:00 trinity kernel: 48957ca8:  [<082c23be>] s=
ock_sendmsg+0x7e/0xa0
2013-07-13T22:09:13.673+02:00 trinity kernel: 48957d6c:  [<082c378a>] S=
yS_sendto+0xea/0x120
2013-07-13T22:09:13.673+02:00 trinity kernel: 48957e44:  [<082c37f6>] S=
yS_send+0x36/0x40
2013-07-13T22:09:13.673+02:00 trinity kernel: 48957e64:  [<082c4247>] S=
yS_socketcall+0x167/0x300
2013-07-13T22:09:13.678+02:00 trinity kernel: 48957eac:  [<080618e2>] h=
andle_syscall+0x82/0xb0
2013-07-13T22:09:13.678+02:00 trinity kernel: 48957ef4:  [<08073d6d>] u=
serspace+0x46d/0x590
2013-07-13T22:09:13.678+02:00 trinity kernel: 48957fec:  [<0805e65c>] f=
ork_handler+0x6c/0x70
2013-07-13T22:09:13.678+02:00 trinity kernel: 48957ffc:  [<00000000>] 0=
x0
2013-07-13T22:09:13.678+02:00 trinity kernel:
2013-07-13T22:09:13.678+02:00 trinity kernel: FIX kmalloc-256: Restorin=
g 0x49b1ed18-0x49b1ed1b=3D0x6b
2013-07-13T22:09:13.678+02:00 trinity kernel:
2013-07-13T22:09:13.678+02:00 trinity kernel: FIX kmalloc-256: Marking =
all objects used
2013-07-13T22:09:13.000+02:00 trinity mount[1049]: mount to NFS server =
'n22stab4' failed: No route to host, retrying
2013-07-13T22:09:16.000+02:00 trinity mount[1048]: mount to NFS server =
'n22stab4' failed: No route to host, retrying
2013-07-13T22:09:16.648+02:00 trinity kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2013-07-13T22:09:16.648+02:00 trinity kernel: BUG kmalloc-256 (Tainted:=
 G    B       ): Poison overwritten
2013-07-13T22:09:16.648+02:00 trinity kernel: -------------------------=
----------------------------------------------------
2013-07-13T22:09:16.648+02:00 trinity kernel:





--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

