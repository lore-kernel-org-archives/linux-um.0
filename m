Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 29 Mar 2018 21:21:58 +0100
In-Reply-To: <4286effd-df51-78c7-3e65-b8a90e1733f0@users.sourceforge.net>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
 <4286effd-df51-78c7-3e65-b8a90e1733f0@users.sourceforge.net>
MIME-Version: 1.0
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <6EFC5A41-3A52-4C6D-A9F0-548158859755@kot-begemot.co.uk>
Subject: Re: [uml-devel] [0/9] UML vector network driver: Adjustments for
 three function implementations
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3639560548702958681=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: SF Markus Elfring <elfring@users.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-user@lists.sourceforge.net

--===============3639560548702958681==
Content-Type: multipart/alternative; boundary="----AIMBDNV77T0PWV3P9KABH87GWONHGN"
Content-Transfer-Encoding: 7bit

------AIMBDNV77T0PWV3P9KABH87GWONHGN
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yes,

Next version though, I have some tweaks enqueued for the socket initializa=
tion=2E We can combine them with these=2E=20

On 29 March 2018 20:51:55 BST, SF Markus Elfring <elfring@users=2Esourcefo=
rge=2Enet> wrote:
>> Date: Sun, 11 Mar 2018 16:06:16 +0100
>>=20
>> Some update suggestions were taken into account
>> from static source code analysis=2E
>=E2=80=A6
>>   Delete unnecessary code in user_init_raw_fds()
>>   Less checks in user_init_raw_fds() after error detection
>>   Adjust an error message in user_init_socket_fds()
>>   Delete an unnecessary check before kfree() in
>user_init_socket_fds()
>>   Delete two unnecessary checks before freeaddrinfo() in
>user_init_socket_fds()
>>   Less checks in user_init_socket_fds() after error detection
>>   Adjust an error message in user_init_tap_fds()
>>   Less checks in user_init_tap_fds() after error detection
>>   Delete an unnecessary variable initialisation in
>user_init_tap_fds()
>=E2=80=A6
>
>Would you like to pick any idea up from this patch series?
>=09
>Regards,
>Markus

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
------AIMBDNV77T0PWV3P9KABH87GWONHGN
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Yes,<br>
<br>
Next version though, I have some tweaks enqueued for the socket initializa=
tion=2E We can combine them with these=2E <br><br><div class=3D"gmail_quote=
">On 29 March 2018 20:51:55 BST, SF Markus Elfring &lt;elfring@users=2Esour=
ceforge=2Enet&gt; wrote:<blockquote class=3D"gmail_quote" style=3D"margin: =
0pt 0pt 0pt 0=2E8ex; border-left: 1px solid rgb(204, 204, 204); padding-lef=
t: 1ex;">
<pre class=3D"k9mail"><blockquote class=3D"gmail_quote" style=3D"margin: 0=
pt 0pt 1ex 0=2E8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"> Da=
te: Sun, 11 Mar 2018 16:06:16 +0100<br> <br> Some update suggestions were t=
aken into account<br> from static source code analysis=2E<br></blockquote>=
=E2=80=A6<br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1ex=
 0=2E8ex; border-left: 1px solid #729fcf; padding-left: 1ex;">   Delete unn=
ecessary code in user_init_raw_fds()<br>   Less checks in user_init_raw_fds=
() after error detection<br>   Adjust an error message in user_init_socket_=
fds()<br>   Delete an unnecessary check before kfree() in user_init_socket_=
fds()<br>   Delete two unnecessary checks before freeaddrinfo() in user_ini=
t_socket_fds()<br>   Less checks in user_init_socket_fds() after error dete=
ction<br>   Adjust an error message in user_init_tap_fds()<br>   Less check=
s in user_init_tap_fds() after error detection<br>   Delete an unnecessary =
variable initialisation in user_init_tap_fds()<br></blockquote>=E2=80=A6<br=
><br>Would you like to pick any idea up from this patch series?<br>	<br>Reg=
ards,<br>Markus<br><br></pre></blockquote></div><br>
-- <br>
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E</=
body></html>
------AIMBDNV77T0PWV3P9KABH87GWONHGN--


--===============3639560548702958681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============3639560548702958681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3639560548702958681==--


