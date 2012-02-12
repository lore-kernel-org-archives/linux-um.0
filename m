Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4F382E6E.4060201@nod.at>
Date: Sun, 12 Feb 2012 22:26:06 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <20120130192552.GL23916@ZenIV.linux.org.uk> <1328311063-17630-1-git-send-email-richard@nod.at> <20120204001431.GY23916@ZenIV.linux.org.uk> <4F2C7F7A.1090605@nod.at> <20120212202728.GR23916@ZenIV.linux.org.uk> <4F3828BD.7070809@nod.at> <20120212212003.GU23916@ZenIV.linux.org.uk>
In-Reply-To: <20120212212003.GU23916@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Cleanup headers files
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 12.02.2012 22:20, schrieb Al Viro:
> On Sun, Feb 12, 2012 at 10:01:49PM +0100, Richard Weinberger wrote:
>> Am 12.02.2012 21:27, schrieb Al Viro:
>>>> So, I pulled your work and merged it into my shiny new UML tree:
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
>>>
>>> Hmm...  I would really, really recommend you to clean the git histo=
ry in that
>>> tree up.  As it is, you have
>>> 	* merge of that branch from um-headers
>>> 	* um: Switch to large mcmodel on x86_64
>>> 	* um: Serve io_remap_pfn_range()
>>> 	* 205 merges from Linus, from mid-April to late January.
>>> 	* mismerge from Linus on April 14; the diff between the result
>>
>> Okay, I'll create a new tree. This one is definitely screwed.
>> Sorry for the inconvenience.
>
> Just create a new branch in the old one, populate it, verify that the
> tree is what you want it to be, switch to your regular branch,
> git reset --hard<the branch you've just built>, then git push --force
> It's not worse than removal of old tree and replacing it with new one=
,
> and it's less work...

It looks like my master branch is screwed. :=E2=A8=AA\
Anyway, I'll fix it!

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

