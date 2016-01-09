Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: Fix get_signal() usage
References: <1447836703-32594-1-git-send-email-richard@nod.at>
 <20160109035125.GA365@ZenIV.linux.org.uk>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5690D845.5090308@nod.at>
Date: Sat, 9 Jan 2016 10:52:05 +0100
MIME-Version: 1.0
In-Reply-To: <20160109035125.GA365@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 09.01.2016 um 04:51 schrieb Al Viro:
> On Wed, Nov 18, 2015 at 09:51:43AM +0100, Richard Weinberger wrote:
>> If get_signal() returns us a signal to post
>> we must not call it again, otherwise the already
>> posted signal will be overridden.
>> Before commit a610d6e672d this was the case as we stopped
>> the while after a successful handle_signal().
> 
> Old behaviour had been wrong.  If you have several pending signals,
> more than one sigframe should be built, as if the second, etc. had
> been delivered right on the entry into the handler.
> 
> Stopping after the first one is obviously wrong - consider the case
> when attempt to deliver it has raised SIGSEGV.

You are right. Thanks for pointing this out.
Will revert.

Thanks,
//richard

