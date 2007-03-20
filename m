Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTYvr-0006U2-6Y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Mar 2007 00:38:59 -0700
Received: from sainfoin.extra.cea.fr ([132.166.172.103])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HTYvo-0007TW-Dz
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Mar 2007 00:38:59 -0700
Received: from nephilia.intra.cea.fr (nephilia.intra.cea.fr [132.166.88.33])
	by sainfoin.extra.cea.fr (8.13.7/8.13.4/CEAnet-Internet.7.0) with ESMTP
	id l2K7cdmZ008755 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 20 Mar 2007 08:38:39 +0100 (MET)
Received: from muguet.saclay.cea.fr (muguet.saclay.cea.fr [132.166.192.6])
	by nephilia.intra.cea.fr (8.13.8/8.13.8) with ESMTP id l2K7ccfK027191
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 20 Mar 2007 08:38:38 +0100 (envelope-from jc.lafoucriere@cea.fr)
Received: from zia.bruyeres.cea.fr (esteban.dam.intra.cea.fr [132.165.76.10])
	by muguet.saclay.cea.fr (8.13.8/8.13.4/CEAnet-internes.7.0) with
	SMTP id l2K7ccXU003004
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 20 Mar 2007 08:38:38 +0100 (MET)
Message-ID: <45FF8F49.4040500@cea.fr>
Date: Tue, 20 Mar 2007 08:37:45 +0100
From: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>
MIME-Version: 1.0
References: <45FE5141.3030007@cea.fr>
	<20070319174857.GE11790@c2.user-mode-linux.org>
In-Reply-To: <20070319174857.GE11790@c2.user-mode-linux.org>
Subject: Re: [uml-devel] 2.6.18 UML machine on FC6 host
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1755341321=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1755341321==
Content-Type: multipart/alternative;
	boundary="------------020806000109020904090301"

This is a multi-part message in MIME format.
--------------020806000109020904090301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Jeff Dike wrote:
> On Mon, Mar 19, 2007 at 10:00:49AM +0100, Jacques-Charles Lafoucriere wrote:
>   
>> I am trying to build and run a UML 2.6.18 machine on a FC6 host. 
>> (2.6.18-1.2798)
>>     
>
> Why are you insisting on a 2.6.18 UML?
>   
I work on some  kernel product that will be available on RHEL5 which 
uses 2.6.18
And RHEL5 kernel does not work in the UML target, so a vanilla 2.6.18 is 
the closest kernel
I want to avoid a 2.6.20 or later port of the product

>   
>> I have tried many patches from the list and was not able to be successful
>> (hang after VFS: Mounted root (ext3 filesystem) readonly.)
>>     
>
> Try 2.6.21-rc4 or this patch:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=14251809b1921b1216568700f1be2f91a1cbb5c7
>   
Ok I will try

--------------020806000109020904090301
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Jeff Dike wrote:
<blockquote cite="mid20070319174857.GE11790@c2.user-mode-linux.org"
 type="cite">
  <pre wrap="">On Mon, Mar 19, 2007 at 10:00:49AM +0100, Jacques-Charles Lafoucriere wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am trying to build and run a UML 2.6.18 machine on a FC6 host. 
(2.6.18-1.2798)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Why are you insisting on a 2.6.18 UML?
  </pre>
</blockquote>
I work on some&nbsp; kernel product that will be available on RHEL5 which
uses 2.6.18<br>
And RHEL5 kernel does not work in the UML target, so a vanilla 2.6.18
is the closest kernel<br>
I want to avoid a 2.6.20 or later port of the product<br>
<br>
<blockquote cite="mid20070319174857.GE11790@c2.user-mode-linux.org"
 type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have tried many patches from the list and was not able to be successful
(hang after VFS: Mounted root (ext3 filesystem) readonly.)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Try 2.6.21-rc4 or this patch:
<a class="moz-txt-link-freetext" href="http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=14251809b1921b1216568700f1be2f91a1cbb5c7">http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=14251809b1921b1216568700f1be2f91a1cbb5c7</a>
  </pre>
</blockquote>
Ok I will try<br>
</body>
</html>

--------------020806000109020904090301--


--===============1755341321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1755341321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1755341321==--
