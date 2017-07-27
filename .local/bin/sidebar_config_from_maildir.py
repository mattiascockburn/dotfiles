#!/usr/bin/env python2

# sidebar_config_from_maildir.py
#
############################################################################
# Script to populate a mutt sidebar configuration file
# File will be written to ~/.mutt/sidebar - you're the one who'll have to 
# include it in your mutt configuration.
#
# Configuration : 
#  * hiddenDirs : directories that you do not wish to show in the sidebar
#  * baseDir : the base directory under which your maildirs are stored
#  * workingDirs : the actual Maildirs, found under baseDir
#  * fc : the other sidebar configuration.  Make sure the "mailboxes" 
#         directive remains unaltered and the list item of the list!
#
############################################################################
#
# Copyright (c) 2009, Erik Heeren
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification, 
# are permitted provided that the following conditions are met:
# 
# * Redistributions of source code must retain the above copyright notice, 
#   this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice, 
#   this list of conditions and the following disclaimer in the documentation 
#   and/or other materials provided with the distribution.
# * Neither the name of the owner nor the names of its contributors may be used 
#   to endorse or promote products derived from this software without specific 
#   prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.

import os
import sys
# Don't show these directories in the sidebar:
hiddenDirs = [ "[Gmail]", "Mail", "Drafts", "outbox", "Sent Mail", "Trash", 
               "Sync Issues", "Calendar", "Contacts", "Journal", "Notes", "Tasks", 
               "RSS Feeds", "Junk", "Public", "Sent", "sent", "Shared Folders", "Deleted Items",
               "Sent Items", "Junk E-mail", "Outbox", "Public Folders"]

homeDir = os.getenv("HOME")
baseDir = os.path.join(homeDir, "mail")
muttDir = os.path.join(homeDir, ".mutt")
# Account folders to check for subfolders
#workingDirs = [ "B1", "mgweb.de", "uberspace" ]

if sys.argv[1] is None:
    print 'fooo!'
    sys.exit(1)

workingDirs=[ sys.argv[1], ]


#fc = [ "set sidebar_width=30", 
#       "set sidebar_visible=yes", 
#       "set sidebar_delim=\"|\"", 
#       "color sidebar_new yellow default", 
#       "unmailboxes * " ,
#       "mailboxes \\" ]
fc = []

dirs = []

# TODO: Recursion into subdirectories
for workingDir in workingDirs:
    for dir in os.listdir(os.path.join(baseDir, workingDir)):
        if dir in hiddenDirs:
            continue
        dirs.append("+%s" % (dir,))
#        dirs.append("    +%s/%s \\" % (workingDir, dir))

dirs.sort()
fc = fc + dirs

#fc = "\n".join(fc).rstrip("\\")
fc = " ".join(fc)

#f = open(os.path.join(muttDir, "sidebar"), "w")
#f.write(fc)
#f.close()

print fc
