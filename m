Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <rob@landley.net>) id 1QHJTW-0004XU-Di
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 May 2011 17:33:30 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QHJTV-0002dO-Dn
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 May 2011 17:33:30 +0000
Received: by ywg8 with SMTP id 8so163992ywg.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 03 May 2011 10:33:24 -0700 (PDT)
Message-ID: <4DC034FE.8030007@landley.net>
Date: Tue, 03 May 2011 12:01:50 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
References: <20110327102305.7569.86213.stgit@zaytsev.su>
	<AANLkTinCW4VUEp6b8Ktj5Wm-141oHdrt3y8TTBeqZWTo@mail.gmail.com>
In-Reply-To: <AANLkTinCW4VUEp6b8Ktj5Wm-141oHdrt3y8TTBeqZWTo@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH] tunctl: Allow non-persitent interfaces
To: user-mode-linux-devel@lists.sourceforge.net

On 03/27/2011 10:20 AM, richard -rw- weinberger wrote:
> On Sun, Mar 27, 2011 at 12:28 PM, Alexey Zaytsev
> <alexey.zaytsev@gmail.com> wrote:
>> Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
>> ---
> 
> Alexey,
> 
>> Hello, uml people. Does someone still maintain the uml utilities? You've been
>> a bit quiet for the last 4 years, but now I've got a patch for you to apply. It's
>> handy when you run qemu (or anything else that wants persistent tunnels)
>> inside openvz containers:
>> http://wiki.openvz.org/VPN_via_the_TUN/TAP_device#The_tunctl_problem
...
>> +  fprintf(stderr, "\t-m will daemonize before slleeping, only makes sense with -n\n");
>> +

Typo, "slleeping".

Rob

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

