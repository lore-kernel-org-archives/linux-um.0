Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 22 Aug 2012 16:23:37 +0300
Message-ID: <CAKiyQA_p+wCCYEmsrau7X=V8mtcY1+MdpDX9RZz8PLB0sQHKuA@mail.gmail.com>
From: Dragos Diaconescu <diaconescud@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5704744993208662693=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] TSC register
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

--===============5704744993208662693==
Content-Type: multipart/alternative; boundary=0015174be30292555804c7daa62b

--0015174be30292555804c7daa62b
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I am currently writing a kernel module that I would like to use it in the
UML, on ubuntu.
In this module I have some events that I would like to generate with a ns
precision. (e.g every 10 ns).

On an ubuntu kernel I used a busy waiting, with  ndelay function which uses
the TSC register, but
I have noticed that this register cannot be read from an UML.
Can you tell me please what is the reason for not being able to read the
TSC register from kernel,
and if there is other possibility to obtain ns precision as the ndelay
implementation has?

Best wishes,

Dragos

--0015174be30292555804c7daa62b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I am currently writing a kernel module that I would like to u=
se it in the UML, on ubuntu.<br>In this module I have some events that I wo=
uld like to generate with a ns precision. (e.g every 10 ns).<br><br>On an u=
buntu kernel I used a busy waiting, with=A0 ndelay function which uses the =
TSC register, but<br>
I have noticed that this register cannot be read from an UML. <br>Can you t=
ell me please what is the reason for not being able to read the TSC registe=
r from kernel,<br>and if there is other possibility to obtain ns precision =
as the ndelay implementation has?<br>
<br>Best wishes,<br><br>Dragos <br>

--0015174be30292555804c7daa62b--


--===============5704744993208662693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============5704744993208662693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5704744993208662693==--


