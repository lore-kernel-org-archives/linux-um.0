Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FivZH-0007HT-22 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 May 2006 08:46:39 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FivZH-00012j-4e for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 May 2006 08:46:39 -0700
Received: from terminus.zytor.com ([192.83.249.54] ident=root)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FivZF-0006Ev-Tt
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 May 2006 08:46:39 -0700
Message-ID: <44747FD0.4070605@zytor.com>
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <E1FipyN-0004Hz-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1FipyN-0004Hz-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: UML boot failure with kinit
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
Date: Wed, 24 May 2006 08:46:24 -0700
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org

Miklos Szeredi wrote:
> UML now compiles on 2.6.17-rc4-mm3, but it fails to boot:
> 
> [...]
> kinit: do_mounts
> kinit: name_to_dev_t(98:0) = dev(0,0)
> kinit: root_dev = dev(0,0)
> kinit: trying to mount /dev/root on /root with type ext3
> kinit: Cannot open root device dev(0,0)
> [...]
> 
> Adding 'root=ubda' to the command line cures it.
> 

Jeff Dike reported this one yesterday; it's fixed in my git tree.

Thanks!

	-hpa


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
