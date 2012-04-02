Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1SEgJw-0003ym-N9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 12:25:16 +0000
Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SEgJs-0002yc-SY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 12:25:16 +0000
Received: by lagw12 with SMTP id w12so4343122lag.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 02 Apr 2012 05:25:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F7999EE.6030003@debian.org>
References: <0uvj49xgsm.ln2@news.researchut.com>
	<CAFLxGvx2fDWexwA1wmLZ4T0EDaUcaMiROrP-_diQi6bGTNEkyw@mail.gmail.com>
	<4F795309.7030206@debian.org>
	<CAFLxGvxiCjYUkjYye8QW_6MRt7VgGrqrJrwN_M375VTGYaUEsg@mail.gmail.com>
	<4F7999EE.6030003@debian.org>
Date: Mon, 2 Apr 2012 14:25:06 +0200
Message-ID: <CAFLxGvyOT9O8L2nisgLTBFpBkujeJ-HNB+Gb3=vnOnb9Z6CJMw@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] uml build failure on arch i386
To: rrs@debian.org
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Apr 2, 2012 at 2:22 PM, Ritesh Raj Sarraf <rrs@debian.org> wrote:
> On Monday 02 April 2012 01:20 PM, richard -rw- weinberger wrote:
>>> Config file available at:
>>> > http://people.debian.org/~rrs/tmp/config.i386
>> Please give the attached patch a try!
>>
>
> Thank you Richard. The patch fixes the build failure on i386.

Okay. :-)
I'll queue it for -stable and 3.4-rc2.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

