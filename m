Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 5 Sep 2011 14:04:27 +0800
Message-ID: <CAOz0Q7UdcfyxvaXRj_0XmDmjZhnex8k2VDtrh+OhUWuDErRLYQ@mail.gmail.com>
From: Qin Bo <kinboster@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1319317391790019288=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] when config network helper_wait failed
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, pkg-uml-pkgs@lists.alioth.debian.org

--===============1319317391790019288==
Content-Type: multipart/alternative; boundary=20cf307d05e8cb4bbc04ac2b7b9a

--20cf307d05e8cb4bbc04ac2b7b9a
Content-Type: text/plain; charset=ISO-8859-1

hi all:
    I download kernel from:
http://uml.devloop.org.uk/kernels/kernel64-2.6.35.14.bz2,
    download linux filesystem from:
http://fs.devloop.org.uk/filesystems/Debian-Squeeze/Debian-Squeeze-AMD64-root_fs.bz2
.
    After umcompress I do following steps:
    1) chmod +x   ./kernel64-2.6.35.14
    2)./kernel64-2.6.35.14 Debian-Squeeze-AMD64-root_fs umid=debian mem=256m
eth0=tuntap,,,192.168.0.254
     In uml:
    1).use root login without password.
    2). ifconfig eth0 192.168.0.253 up
[   18.370000] helper_wait : waitpid process 26858 failed, errno = 10
[   18.370000] * modprobe tun
[   18.370000] * ifconfig tap0 192.168.0.254 netmask 255.255.255.255 up
[   18.370000] * bash -c echo 1 > /proc/sys/net/ipv4/ip_forward
[   18.370000] helper_wait : waitpid process 26867 failed, errno = 10
[   18.370000] * route add -host 192.168.0.253 dev tap0
[   18.370000] * bash -c echo 1 > /proc/sys/net/ipv4/conf/tap0/proxy_arp
    3)ping -c 3 192.168.0.254
PING 192.168.0.254 (192.168.0.254) 56(84) bytes of data.
Warning: time of day goes back (-17544us), taking countermeasures.
64 bytes from 192.168.0.254: icmp_req=1 ttl=64 time=0.259 ms
64 bytes from 192.168.0.254: icmp_req=2 ttl=64 time=0.313 ms
64 bytes from 192.168.0.254: icmp_req=3 ttl=64 time=0.403 ms

   At uml step 2 have two failed: "helper_wait : waitpid process 26858
failed, errno = 10", but the network is reachable.
 When I run: ps axu|grep uml
uml-net   1352  0.0  0.0   3864   452 ?        S    08:51   0:00
/usr/bin/uml_switch -unix /var/run/uml-utilities/uml_switch.ctl
root     23417  0.0  0.0      0     0 pts/3    Z+   13:31   0:00 [uml_net]
<defunct>
root     23422  0.0  0.0      0     0 pts/3    Z+   13:31   0:00 [uml_net]
<defunct>
   have two zombie process here. When I run:
   linux Debian-Squeeze-AMD64-root_fs umid=debian mem=256m
eth0=tuntap,,,192.168.0.254
   have the same problem.Any idea ?
   I use debian 6.0 squeeze , uml-utilities version Version: 20070815-1.1

-- 
Best Regards,
Qin Bo

--20cf307d05e8cb4bbc04ac2b7b9a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>hi all:</div><div>=A0 =A0 I download kernel from: <a href=3D"http://um=
l.devloop.org.uk/kernels/kernel64-2.6.35.14.bz2" target=3D"_blank">http://u=
ml.devloop.org.uk/kernels/kernel64-2.6.35.14.bz2</a>,</div><div>=A0 =A0 dow=
nload linux filesystem from: <a href=3D"http://fs.devloop.org.uk/filesystem=
s/Debian-Squeeze/Debian-Squeeze-AMD64-root_fs.bz2" target=3D"_blank">http:/=
/fs.devloop.org.uk/filesystems/Debian-Squeeze/Debian-Squeeze-AMD64-root_fs.=
bz2</a>.</div>

<div>=A0 =A0 After umcompress I do following steps:</div><div>=A0 =A0 1) ch=
mod +x =A0 ./kernel64-2.6.35.14</div><div>=A0 =A0 2)./kernel64-2.6.35.14 De=
bian-Squeeze-AMD64-root_fs umid=3Ddebian mem=3D256m eth0=3Dtuntap,,,192.168=
.0.254</div><div>
=A0 =A0 =A0In uml:</div><div>=A0 =A0 1).use root login without password.</d=
iv><div>=A0 =A0 2). ifconfig eth0 192.168.0.253 up =A0=A0</div><div>[ =A0 1=
8.370000] helper_wait : waitpid process 26858 failed, errno =3D 10</div><di=
v>[ =A0 18.370000] * modprobe tun</div>

<div>[ =A0 18.370000] * ifconfig tap0 192.168.0.254 netmask 255.255.255.255=
 up</div><div>[ =A0 18.370000] * bash -c echo 1 &gt; /proc/sys/net/ipv4/ip_=
forward</div><div>[ =A0 18.370000] helper_wait : waitpid process 26867 fail=
ed, errno =3D 10</div>

<div>[ =A0 18.370000] * route add -host 192.168.0.253 dev tap0</div><div>[ =
=A0 18.370000] * bash -c echo 1 &gt; /proc/sys/net/ipv4/conf/tap0/proxy_arp=
</div><div>=A0 =A0 3)ping -c 3 192.168.0.254</div><div>PING 192.168.0.254 (=
192.168.0.254) 56(84) bytes of data.</div>

<div>Warning: time of day goes back (-17544us), taking countermeasures.</di=
v><div>64 bytes from <a href=3D"http://192.168.0.254" target=3D"_blank">192=
.168.0.254</a>: icmp_req=3D1 ttl=3D64 time=3D0.259 ms</div><div>64 bytes fr=
om <a href=3D"http://192.168.0.254" target=3D"_blank">192.168.0.254</a>: ic=
mp_req=3D2 ttl=3D64 time=3D0.313 ms</div>

<div>64 bytes from <a href=3D"http://192.168.0.254" target=3D"_blank">192.1=
68.0.254</a>: icmp_req=3D3 ttl=3D64 time=3D0.403 ms</div><div><br></div><di=
v>=A0 =A0At uml step 2 have two failed: &quot;helper_wait : waitpid process=
 26858 failed, errno =3D 10&quot;, but the network is reachable.</div>

<div>=A0When I run: ps axu|grep uml</div><div>uml-net =A0 1352 =A00.0 =A00.=
0 =A0 3864 =A0 452 ? =A0 =A0 =A0 =A0S =A0 =A008:51 =A0 0:00 /usr/bin/uml_sw=
itch -unix /var/run/uml-utilities/uml_switch.ctl</div><div>root =A0 =A0 234=
17 =A00.0 =A00.0 =A0 =A0 =A00 =A0 =A0 0 pts/3 =A0 =A0Z+ =A0 13:31 =A0 0:00 =
[uml_net] &lt;defunct&gt;</div>

<div>root =A0 =A0 23422 =A00.0 =A00.0 =A0 =A0 =A00 =A0 =A0 0 pts/3 =A0 =A0Z=
+ =A0 13:31 =A0 0:00 [uml_net] &lt;defunct&gt;</div><div>=A0 =A0have two zo=
mbie process here. When I run:=A0</div><div>=A0 =A0linux Debian-Squeeze-AMD=
64-root_fs umid=3Ddebian mem=3D256m eth0=3Dtuntap,,,192.168.0.254</div>

<div>=A0 =A0have the same problem.Any idea ?</div><div>=A0 =A0I use debian =
6.0 squeeze , uml-utilities version Version: 20070815-1.1</div><div><br></d=
iv>-- <br><font color=3D"#888888">Best Regards,<br>
Qin Bo<br></font><br>

--20cf307d05e8cb4bbc04ac2b7b9a--


--===============1319317391790019288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
--===============1319317391790019288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1319317391790019288==--


