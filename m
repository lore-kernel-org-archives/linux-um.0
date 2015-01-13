Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54B59B9E.4000806@nod.at>
Date: Tue, 13 Jan 2015 23:26:38 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1421187358-32600-1-git-send-email-richard@nod.at> <20150113221958.GA27739@infradead.org>
In-Reply-To: <20150113221958.GA27739@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] hostfs: Use noop_fsync for directories
To: Christoph Hellwig <hch@infradead.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, dxld@darkboxed.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 13.01.2015 um 23:19 schrieb Christoph Hellwig:
> On Tue, Jan 13, 2015 at 11:15:58PM +0100, Richard Weinberger wrote:
>> Daniel reported that dpkg(1) dies if the root filesystem is a hostfs
>> because it does not expect fsync(2) to fail with EINVAL on directories.
>> While fsync(2) is allowed to fail with EINVAL if the filesystem does not
>> support it we can do better and use noop_fsync() to not confuse userspace
>> further.
> 
> Shouldn't hostfs pass the fsync through to the host filesystem?

hostfs tries do reduce the amount of syscall between guest and host as much
as possible. For file operations it passes everything down to the host but
for directory operations only ->iterate() does.

It is already horrible slow, if we add an ->open() for directory too it would
get even more slower. :-(

Thanks,
//richard
