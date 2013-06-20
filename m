Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <51C21645.3050108@google.com>
References: <51C21645.3050108@google.com>
From: Tristan Schmelcher <tschmelcher@google.com>
Date: Thu, 20 Jun 2013 09:36:05 -0400
Message-ID: <CADNZ+wRMzCxeUr5nUU43TunCsdN4+S8wHkzAVYvQPsq9G0=PwQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCHv2] uml: Fix which_tmpdir failure when /dev/shm is a
 symlink, and in other edge cases
To: Richard Weinberger <richard@nod.at>, jdike@addtoit.com
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

*sigh* found another bug. Gonna sit on the patch for a bit before
sending v3, just in case I find more issues.
