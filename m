Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Aeqwr-0002kY-NA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jan 2004 23:20:49 -0800
Received: from [81.193.166.163] (helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Aeqwr-0008Fs-4M for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jan 2004 23:20:49 -0800
Message-ID: <3FFE56BC.60202@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: Resolution (Re: [uml-devel] 2.4.22-[67] problems)
References: <20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net>
	<20031228093317.GK17472@alcor.net>
	<20031228095115.GL17472@alcor.net>
	<20031228101240.GN17472@alcor.net>
	<20031228113042.GO17472@alcor.net>
	<20031230184330.GD1365@alcor.net>
	<200401060258.i062wWFI023087@ccure.user-mode-linux.org>
	<3FFA66B3.501@vgertech.com> <3FFA7DC6.1040403@vgertech.com>
	<20040106171301.GY28393@alcor.net>
In-Reply-To: <20040106171301.GY28393@alcor.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 09 Jan 2004 07:22:36 +0000
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org



Matt Zimmerman wrote:
>>puma:/uml# fg
>>./linux
>>Segmentation fault
>>puma:/uml#
> 
> 
> This looks quite different from what I and others were seeing in #224431,
> which was random ENOSYS errors because the system call number in the regs
> struct was being mysteriously cleared during a context switch on the cost.

Yes, probably not the same issue.

I've made some new tests and I'd say that my problem relates to NPTL in 
glibc. (I don't have a fix, yet :( )

I'll open another thread :-)

Regards,
Nuno Silva



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
