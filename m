Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51C3062F.6000304@nod.at>
Date: Thu, 20 Jun 2013 15:39:59 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <51C21645.3050108@google.com> <CADNZ+wRMzCxeUr5nUU43TunCsdN4+S8wHkzAVYvQPsq9G0=PwQ@mail.gmail.com>
In-Reply-To: <CADNZ+wRMzCxeUr5nUU43TunCsdN4+S8wHkzAVYvQPsq9G0=PwQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCHv2] uml: Fix which_tmpdir failure when /dev/shm is a symlink,
 and in other edge cases
To: Tristan Schmelcher <tschmelcher@google.com>
Cc: jdike@addtoit.com, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 20.06.2013 15:36, schrieb Tristan Schmelcher:
> *sigh* found another bug. Gonna sit on the patch for a bit before
> sending v3, just in case I find more issues.

No need to hurry. :-)
As the patch is non-trivial it's 3.11 material anyway.

Thanks,
//richard


