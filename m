Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1d9UkU-0007rh-QG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 10:58:10 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
	helo=www.kot-begemot.co.uk)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d9UkT-00006e-99
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 10:58:10 +0000
Date: Sat, 13 May 2017 11:57:51 +0100
In-Reply-To: <7ac6769e-9907-7c1d-d4c5-e70724a73866@m3y3r.de>
References: <20170513101046.Horde.P7MZvg1O0xNi0CnTODsXRIH@webmail.your-server.de>
	<CAFLxGvyoYQU0e+_pHMZ2k0S3mxNJt9xshN_hrNMAYiTVBLkmMA@mail.gmail.com>
	<7ac6769e-9907-7c1d-d4c5-e70724a73866@m3y3r.de>
MIME-Version: 1.0
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <422A3C61-2A4F-473E-B755-E0CD23491ACC@kot-begemot.co.uk>
Subject: Re: [uml-devel] userfaultfd for UML userspace processes
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5898915578969267205=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, Thomas Meyer <thomas@m3y3r.de>, Richard Weinberger <richard.weinberger@gmail.com>

--===============5898915578969267205==
Content-Type: multipart/alternative;
	boundary="----LVHS1P21CNMKS6Z7L9PSRQ62BODVJA"
Content-Transfer-Encoding: 7bit

------LVHS1P21CNMKS6Z7L9PSRQ62BODVJA
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am I right that this may be a route to avoid the full munmap we have presen=
tly upon exec or I am missing something=2E  If that is the case it will be =
well worth it=2E

On 13 May 2017 11:24:04 GMT+01:00, Thomas Meyer <thomas@m3y3r=2Ede> wrote:
>Am 13=2E05=2E2017 um 12:04 schrieb Richard Weinberger:
>> Thomas,
>
>Hi,
>
>> On Sat, May 13, 2017 at 10:10 AM, Thomas Meyer <thomas@m3y3r=2Ede>
>wrote:
>>>
>>> Hi,
>>>
>>> after looking into using userfaultfd for the userspace UML process
>>> page fault handling, I come to the conclusion that userfaultfd
>>> *cannot* be used for above goal as it only operates on mmaped memory
>>> areas=2E
>>> Am I missing something? What do you think about it?
>>=20
>> See: https://lkml=2Eorg/lkml/2015/5/20/541
>Cool! Thanks for the hint=2E I don't follow LKML, so=2E=2E=2E
>
>But Andrea wrote:
>
>"Alternatively once we extend the handle_userfault to tmpfs you could
>map the page in two virtual mappings and track the faults in one
>mapping (where the tracked app runs) and read/write the page contents
>in the other mapping that isn't tracked by the userfault=2E"
>
>I think this is now the case with 4=2E11, isn't it?
>
>As I understand this we must do the following:
>
>kernel process: Map a tmpfs region for each userspace process with=20
>read/write=2E
>userspace process: Map the same tmpfs for the current process and=20
>userfaultfd the whole address space, and give the userfaultfd fd to the
>
>kernel somehow and process the page fault there and fill/copy the=20
>faulted page accordingly=2E
>
>so each userspace process would be backed by a tmpfs mmap region? sound
>
>complicated=2E
>
>with kind regards
>thomas
>
>
>-------------------------------------------------------------------------=
-----
>Check out the vibrant tech community on one of the world's most
>engaging tech sites, Slashdot=2Eorg! http://sdm=2Elink/slashdot
>_______________________________________________
>User-mode-linux-devel mailing list
>User-mode-linux-devel@lists=2Esourceforge=2Enet
>https://lists=2Esourceforge=2Enet/lists/listinfo/user-mode-linux-devel

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
------LVHS1P21CNMKS6Z7L9PSRQ62BODVJA
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Am I right that this may be a route to avoid the f=
ull munmap we have presently upon exec or I am missing something=2E  If tha=
t is the case it will be well worth it=2E<br><br><div class=3D"gmail_quote"=
>On 13 May 2017 11:24:04 GMT+01:00, Thomas Meyer &lt;thomas@m3y3r=2Ede&gt; =
wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8e=
x; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class=3D"k9mail">Am 13=2E05=2E2017 um 12:04 schrieb Richard Weinberge=
r:<br /><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1ex 0=2E=
8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"> Thomas,<br /></bl=
ockquote><br />Hi,<br /><br /><blockquote class=3D"gmail_quote" style=3D"ma=
rgin: 0pt 0pt 1ex 0=2E8ex; border-left: 1px solid #729fcf; padding-left: 1e=
x;"> On Sat, May 13, 2017 at 10:10 AM, Thomas Meyer &lt;thomas@m3y3r=2Ede&g=
t; wrote:<br /><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1=
ex 0=2E8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;"><br /> Hi,<=
br /><br /> after looking into using userfaultfd for the userspace UML proc=
ess<br /> page fault handling, I come to the conclusion that userfaultfd<br=
 /> *cannot* be used for above goal as it only operates on mmaped memory<br=
 /> areas=2E<br /> Am I missing something? What do you think about it?<br /=
></blockquote> <br /> See: <a href=3D"https://lkml=2Eorg/lkml/2015/5/20/541=
">https://lkml=2Eorg/lkml/2015/5/20/541</a><br /></blockquote>Cool! Thanks =
for the hint=2E I don't follow LKML, so=2E=2E=2E<br /><br />But Andrea wrot=
e:<br /><br />&quot;Alternatively once we extend the handle_userfault to tm=
pfs you could<br />map the page in two virtual mappings and track the fault=
s in one<br />mapping (where the tracked app runs) and read/write the page =
contents<br />in the other mapping that isn't tracked by the userfault=2E&q=
uot;<br /><br />I think this is now the case with 4=2E11, isn't it?<br /><b=
r />As I understand this we must do the following:<br /><br />kernel proces=
s: Map a tmpfs region for each userspace process with <br />read/write=2E<b=
r />userspace process: Map the same tmpfs for the current process and <br /=
>userfaultfd the whole address space, and give the userfaultfd fd to the <b=
r />kernel somehow and process the page fault there and fill/copy the <br /=
>faulted page accordingly=2E<br /><br />so each userspace process would be =
backed by a tmpfs mmap region? sound <br />complicated=2E<br /><br />with k=
ind regards<br />thomas<br /><br /><br /><hr /><br />Check out the vibrant =
tech community on one of the world's most<br />engaging tech sites, <a href=
=3D"http://Slashdot=2Eorg">Slashdot=2Eorg</a>! <a href=3D"http://sdm=2Elink=
/slashdot">http://sdm=2Elink/slashdot</a><br /><hr /><br />User-mode-linux-=
devel mailing list<br />User-mode-linux-devel@lists=2Esourceforge=2Enet<br =
/><a href=3D"https://lists=2Esourceforge=2Enet/lists/listinfo/user-mode-lin=
ux-devel">https://lists=2Esourceforge=2Enet/lists/listinfo/user-mode-linux-=
devel</a><br /><br /></pre></blockquote></div><br>
-- <br>
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E</=
body></html>
------LVHS1P21CNMKS6Z7L9PSRQ62BODVJA--


--===============5898915578969267205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============5898915578969267205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5898915578969267205==--


