Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1gwYzp-0003wG-Im
 for user-mode-linux-devel@lists.sourceforge.NET;
 Wed, 20 Feb 2019 21:01:37 +0000
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gwYzc-003s6R-Pk for user-mode-linux-devel@lists.sourceforge.NET;
 Wed, 20 Feb 2019 21:01:37 +0000
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1gwYVM-0005lD-G8 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 20 Feb 2019 20:30:08 +0000
Received: from amistad.kot-begemot.co.uk ([192.168.3.89])
 by smaug.kot-begemot.co.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1gwYVK-0004eU-2n
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 20 Feb 2019 20:30:08 +0000
References: <BN6PR20MB1937E3301E14A7C38B26DD6DCF7D0@BN6PR20MB1937.namprd20.prod.outlook.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <e336a1db-e23b-2366-9d0e-f9dff5e4e7b9@kot-begemot.co.uk>
Date: Wed, 20 Feb 2019 20:28:50 +0000
MIME-Version: 1.0
In-Reply-To: <BN6PR20MB1937E3301E14A7C38B26DD6DCF7D0@BN6PR20MB1937.namprd20.prod.outlook.com>
Content-Language: en-US
Subject: Re: [uml-devel] UML: Access to a host device from UML
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7816307483928285848=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============7816307483928285848==
Content-Type: multipart/alternative;
 boundary="------------7288E4C26438A31824893D25"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7288E4C26438A31824893D25
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

I do not think that this is possible without an additional device in the=20
UML itself.


In fact, if you want two processes in two different UML instances to=20
communicate in-between themselves you should aim at a UML device. The=20
kernel device is probably suprlus to requirements as the two UML=20
instances can communicate between themselves within the host userspace=20
using any of the mechanisms available for that.


A.


On 2/20/19 6:36 PM, Pablo Pessolani wrote:
> Hi:
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD I wrote an IPC mechanism as a Lin=
ux kernel module. The access=20
> to their services is through a dummy character device called /dev/dvk=20
> using ioctl(). Therefore, only open(), ioctl() and close() system=20
> calls are used.
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD How can a process running within =
an UML Guest access the=20
> /dev/dvk host device?=EF=BF=BD (humfs??)
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD The idea is to communicate two o =
more UML instances through=20
> this IPC mechanism.
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD Thanks in advance.
> Regards.
> PAP
>
>
>
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--=20
Anton R Ivanov

http://www.kot-begemot.co.uk


--------------7288E4C26438A31824893D25
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html;
      charset=3Dwindows-1252">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p>I do not think that this is possible without an additional device
      in the UML itself.</p>
    <p><br>
    </p>
    <p>In fact, if you want two processes in two different UML instances
      to communicate in-between themselves you should aim at a UML
      device. The kernel device is probably suprlus to requirements as
      the two UML instances can communicate between themselves within
      the host userspace using any of the mechanisms available for that.<br>
    </p>
    <p><br>
    </p>
    <p>A.<br>
    </p>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2/20/19 6:36 PM, Pablo Pessolani
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:BN6PR20MB1937E3301E14A7C38B26DD6DCF7D0@BN6PR20MB1937.namprd20.p=
rod.outlook.com">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3Dwindows-1252">
      <style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;mar=
gin-bottom:0;} </style>
      <div style=3D"font-family: Calibri, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Hi:</div>
      <div style=3D"font-family: Calibri, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD I wrote an IPC mechanism as=
 a Linux kernel module. The
        access to their services is through a dummy character device
        called /dev/dvk using ioctl(). Therefore, only open(), ioctl()
        and close() system calls are used.</div>
      <div style=3D"font-family: Calibri, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <span style=3D"color: rgb(0, 0, 0); font-family: Calibri,
          Helvetica, sans-serif; font-size: 12pt;">=EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD How can a
          process running within an UML Guest access the /dev/dvk host
          device?=EF=BF=BD (humfs??)</span></div>
      <div style=3D"font-family: Calibri, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <span style=3D"color: rgb(0, 0, 0); font-family: Calibri,
          Helvetica, sans-serif; font-size: 12pt;">=EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD The idea is
          to communicate two o more UML instances through this IPC
          mechanism.</span></div>
      <div style=3D"font-family: Calibri, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <span style=3D"color: rgb(0, 0, 0); font-family: Calibri,
          Helvetica, sans-serif; font-size: 12pt;">=EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD Thanks in
          advance.</span></div>
      <div style=3D"font-family: Calibri, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <span style=3D"color: rgb(0, 0, 0); font-family: Calibri,
          Helvetica, sans-serif; font-size: 12pt;">Regards.</span></div>
      <div style=3D"font-family: Calibri, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <span style=3D"color: rgb(0, 0, 0); font-family: Calibri,
          Helvetica, sans-serif; font-size: 12pt;">PAP</span></div>
      <div style=3D"font-family: Calibri, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <span style=3D"color: rgb(0, 0, 0); font-family: Calibri,
          Helvetica, sans-serif; font-size: 12pt;"><br>
        </span></div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <pre class=3D"moz-quote-pre" wrap=3D"">______________________________=
_________________
User-mode-linux-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:User-mode-linux-devel@=
lists.sourceforge.net">User-mode-linux-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/user-mode-linux-devel">https://lists.sourceforge.net/lists/lis=
tinfo/user-mode-linux-devel</a>
</pre>
    </blockquote>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Anton R Ivanov

<a class=3D"moz-txt-link-freetext" href=3D"http://www.kot-begemot.co.uk">ht=
tp://www.kot-begemot.co.uk</a></pre>
  </body>
</html>

--------------7288E4C26438A31824893D25--


--===============7816307483928285848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7816307483928285848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7816307483928285848==--


