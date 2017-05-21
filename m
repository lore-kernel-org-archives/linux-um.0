Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1dCYj1-0005FT-K6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2017 21:49:19 +0000
Received: from mail-oi0-f65.google.com ([209.85.218.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dCYj0-0008Vk-Oi
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2017 21:49:19 +0000
Received: by mail-oi0-f65.google.com with SMTP id m17so20080279oik.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 May 2017 14:49:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <088BF58C-CB46-401C-8ECA-29AA0E6A3666@m3y3r.de>
References: <131837db-75e3-f78f-6aae-6b7be8d051a8@m3y3r.de>
	<20170517105216.3f0e66817ed5b84cfc68dcb7@kernel.org>
	<088BF58C-CB46-401C-8ECA-29AA0E6A3666@m3y3r.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 21 May 2017 23:49:12 +0200
Message-ID: <CAFLxGvxtOadjWiOVgfEAEg7SmG3LkLUPs2+oB20n+1-7WR10Jg@mail.gmail.com>
Subject: Re: [uml-devel] [RFC PATCH 1/7] um: Use printk instead of printf in
	make_uml_dir
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
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Wed, May 17, 2017 at 10:35 AM, Thomas Meyer <thomas@m3y3r.de> wrote:
>> On Tue, 16 May 2017 17:46:47 +0200
>> Thomas Meyer <thomas@m3y3r.de> wrote:
>>
>>> Hi,
>>>
>>> as far as I understand everything under os-Linux should be OS specific
>>> and shouldn't rely on kernel functions.
>>
>> I see, but umid.c already uses many printk()s. So that policy
>> is not so clear now. For example, without this series,
>
> Yes you are right. I did write nonsense!
>
> I'm fine with all patches in series. Looks good to me!

Yeah, the policy is not so clear.
In theory os-Linux should contain no kernel stuff, but the printk()s do not
hurt, in most cases.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

