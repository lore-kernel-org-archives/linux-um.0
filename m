Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fkd6h-0007qv-Ie for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 May 2006 01:28:11 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fkd6f-00071g-SO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 May 2006 01:28:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 3EAA03C5CA
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 01:28:09 -0700 (PDT)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18053-02 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 01:28:08 -0700 (PDT)
Received: from SCG2 (c-67-160-154-69.hsd1.or.comcast.net [67.160.154.69])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 52FC93C590
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 01:28:08 -0700 (PDT)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Subject: RE: [uml-devel] Warnings compiling linux-2.6.17-rc5
Message-ID: <LEEIJGBJEEABAGOFFGAHEEHGDGAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <OJEEKGNKKDLJIEPBEJMIEEPICAAA.brocka@sterlingcgi.com>
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
Date: Mon, 29 May 2006 01:28:08 -0700
To: UML Developer's List <user-mode-linux-devel@lists.sourceforge.net>

> -----Original Message-----
> > -----Original Message-----
> > I actually looked through these patches before asking:
> >
> > http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4
> > /patches.t
> > ar
> >
> > I didn't see anything that appeared to address this. However, I'll try
> > applying these and test from there.
>
> I tried these patches but encountered the errors below. While most of the
> patches applied without an issue, I was forced to modify one
> patch before it
> would apply to the 2.6.17-rc5 tree. I had to delete following
> line from the
> patch file externfs:
>
> obj-$(CONFIG_CONFIGFS_FS)       += configfs/
>
> I will retry this compile with externfs disabled.

This appears to have worked (compiled) after I disabled both HUMFS and
EXTERNFS in the config. I will try launching an instance with this
executable in the morning and see how it performs.

However, I wasn't able to disable the EXTERNFS option through the regular
'make menuconfig ARCH=um' command. The option inside the regular menu
interface was already disabled (although the resulting .config file listed
it as enabled). I was forced to manually edit the .config file and comment
it out.

The really strange thing is that AFTER the compile the .config file has
EXTERNFS enabled! Also, the resulting executable agrees with the final
.config file. I've never seen an instance where compiling the kernel changes
options in the .config file. I've even verified that both HUMFS and HOSTFS
are disabled (to prevent these options from auto-enabling EXTERNFS).
However, I've confirmed this behavior twice.

As a result, the only real difference in configuration to fix the compile
was disabling HUMFS.

Tony



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
