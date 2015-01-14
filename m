Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54B62C49.7030309@nod.at>
Date: Wed, 14 Jan 2015 09:43:53 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1421187358-32600-1-git-send-email-richard@nod.at> <20150113221958.GA27739@infradead.org> <54B59B9E.4000806@nod.at> <20150114083951.GA29714@infradead.org>
In-Reply-To: <20150114083951.GA29714@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] hostfs: Use noop_fsync for directories
To: Christoph Hellwig <hch@infradead.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, dxld@darkboxed.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 14.01.2015 um 09:39 schrieb Christoph Hellwig:
> On Tue, Jan 13, 2015 at 11:26:38PM +0100, Richard Weinberger wrote:
>> hostfs tries do reduce the amount of syscall between guest and host as much
>> as possible. For file operations it passes everything down to the host but
>> for directory operations only ->iterate() does.
>>
>> It is already horrible slow, if we add an ->open() for directory too it would
>> get even more slower. :-(
> 
> This sounds fairlt dangerous.  At least add some good documentation
> explaining these semantics.

Understood. Maybe it is time to rebenchmark hostfs with full directory pass-through support.
Daniel, are you interested in a small kernel project?
As explained on IRC adding real support for directory fsync() should be an easy task.
The only interesting point is how much overhead it will add.

Thanks,
//richard
